#!/bin/bash

# Exit on critical setup errors (we will handle verification errors manually at the end)
set -e

# Determine the target user (handles running via sudo or directly as root)
TARGET_USER="${SUDO_USER:-$USER}"
TARGET_HOME=$(eval echo "~$TARGET_USER")
DATA_DIR="$TARGET_HOME/.gspcoincore"
INSTALL_DIR="/usr/local/bin"
WORK_DIR="/tmp/gspcoin_setup"

ZIP_FILE="Bootstrap-Snapshot-24-Oct-2026.zip"
TAR_FILE="gspcoin-ubuntu24-2.2.2.tar.gz"

echo "=========================================="
echo " Starting GSPCoin Daemon Setup"
echo " Target User: $TARGET_USER"
echo " Data Directory: $DATA_DIR"
echo "=========================================="

# Ensure script is run with root privileges for swap and systemd setup
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo (e.g., sudo ./gspcdaemon.sh)"
  exit 1
fi

# Prompt user for RPC credentials before starting installation
echo ""
while [ -z "$INPUT_RPC_USER" ]; do
    read -r -p "Enter desired RPC Username (rpcuser): " INPUT_RPC_USER
    if [ -z "$INPUT_RPC_USER" ]; then
        echo "RPC Username cannot be empty. Please try again."
    fi
done

while [ -z "$INPUT_RPC_PASS" ]; do
    read -r -s -p "Enter desired RPC Password (rpcpassword): " INPUT_RPC_PASS
    echo ""
    if [ -z "$INPUT_RPC_PASS" ]; then
        echo "RPC Password cannot be empty. Please try again."
    fi
done
echo "RPC credentials captured."
echo ""

# Install required dependencies (unzip, wget, tar)
echo "[0/7] Installing required packages (wget, unzip, tar)..."
apt-get update -qq
apt-get install -y -qq wget unzip tar

# 1. Create a swap of 2GB
echo "[1/7] Checking and creating 2GB swap file..."
if swapon --show | grep -q '/swapfile'; then
    echo "Swapfile already exists and is active. Skipping creation."
else
    fallocate -l 2G /swapfile || dd if=/dev/zero of=/swapfile bs=1M count=2048
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    if ! grep -q '/swapfile' /etc/fstab; then
        echo '/swapfile none swap sw 0 0' >> /etc/fstab
    fi
    echo "2GB Swap created and enabled."
fi

# Prepare temporary working directory
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

# 2. Download the 2 files
echo "[2/7] Downloading GSPCoin binaries and bootstrap snapshot..."
wget -q --show-progress -O "$ZIP_FILE" "https://github.com/gamgsp/gspcoin/releases/download/v2.2.2/$ZIP_FILE"
wget -q --show-progress -O "$TAR_FILE" "https://github.com/gamgsp/gspcoin/releases/download/v2.2.2/$TAR_FILE"

# 3. Extract gspcoin-ubuntu24-2.2.2.tar.gz and install binaries
echo "[3/7] Extracting binaries..."
mkdir -p "$WORK_DIR/extracted_bin"
tar -xzf "$TAR_FILE" -C "$WORK_DIR/extracted_bin"

# Find gspcoind and gspcoin-cli inside extracted folders and move them to /usr/local/bin
find "$WORK_DIR/extracted_bin" -type f \( -name "gspcoind" -o -name "gspcoin-cli" \) -exec cp {} "$INSTALL_DIR/" \;
chmod +x "$INSTALL_DIR/gspcoind" "$INSTALL_DIR/gspcoin-cli"

if [ ! -f "$INSTALL_DIR/gspcoind" ]; then
    echo "Error: Could not locate gspcoind binary after extraction."
    exit 1
fi

# 4. Create .gspcoincore and gspcoin.conf
echo "[4/7] Creating data directory and gspcoin.conf..."
mkdir -p "$DATA_DIR"

cat <<EOF > "$DATA_DIR/gspcoin.conf"
rpcuser=$INPUT_RPC_USER
rpcpassword=$INPUT_RPC_PASS
rpcport=15167
server=1
listen=1
addressindex=1
spentindex=1
txindex=1
rpcthreads=16
rpcworkqueue=256
dbcache=256
addnode=15.206.178.246
addnode=109.173.167.18
addnode=92.5.79.95
addnode=144.24.172.207
addnode=81.148.102.220
addnode=129.146.20.199
addnode=212.47.77.200
addnode=94.250.203.169
addnode=37.26.136.250
addnode=129.146.161.225
addnode=37.59.20.42
addnode=223.178.211.104
addnode=[2401:4900:1c2b:5674:93c:d1d7:bdf3:8c9a]
addnode=79.115.88.245
addnode=164.68.112.217
addnode=78.153.91.188
addnode=[2a01:3d8:33d:6a00:e5a0:480e:d942:de49]
addnode=[2a02:842b:1700:3f01:f4fd:412c:511a:83e7]
addnode=37.67.204.246
addnode=37.49.50.54
addnode=[2a02:8071:5a42:2260:5063:98c9:208a:1bee]
addnode=34.87.170.118
addnode=34.165.113.110
addnode=35.237.132.159
addnode=136.87.94.13
EOF

# Restrict permissions on gspcoin.conf to protect RPC credentials
chmod 600 "$DATA_DIR/gspcoin.conf"

# 5. Extract Bootstrap-Snapshot-24-Oct-2026.zip in .gspcoincore folder
echo "[5/7] Extracting bootstrap snapshot into $DATA_DIR..."
unzip -o -q "$ZIP_FILE" -d "$DATA_DIR"

# Delete downloaded archive files and temporary extraction directory
echo "Cleaning up downloaded .tar.gz and .zip files..."
rm -f "$WORK_DIR/$TAR_FILE" "$WORK_DIR/$ZIP_FILE"
cd "$TARGET_HOME"
rm -rf "$WORK_DIR"

# Ensure the target user owns everything in their .gspcoincore directory
chown -R "$TARGET_USER:$TARGET_USER" "$DATA_DIR"

# 6. Create gspcoind systemd service and start it
echo "[6/7] Creating and starting gspcoind systemd service..."
cat <<EOF > /etc/systemd/system/gspcoind.service
[Unit]
Description=GSPCoin Daemon
After=network.target

[Service]
User=$TARGET_USER
Group=$TARGET_USER
Type=forking
ExecStart=$INSTALL_DIR/gspcoind -daemon -conf=$DATA_DIR/gspcoin.conf -datadir=$DATA_DIR
ExecStop=$INSTALL_DIR/gspcoin-cli -conf=$DATA_DIR/gspcoin.conf -datadir=$DATA_DIR stop
Restart=always
RestartSec=10
TimeoutStopSec=60

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable gspcoind
systemctl start gspcoind

# 7. Check blockchain info and verify syncing
echo "[7/7] Waiting 15 seconds for daemon initialization and verifying sync status..."
sleep 15

# Disable exit-on-error for the verification block so we can catch and diagnose failures
set +e

SYNC_SUCCESS=false
MAX_RETRIES=6
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    BLOCKCHAIN_INFO=$(sudo -u "$TARGET_USER" "$INSTALL_DIR/gspcoin-cli" -conf="$DATA_DIR/gspcoin.conf" -datadir="$DATA_DIR" getblockchaininfo 2>&1)
    CLI_EXIT_CODE=$?

    if [ $CLI_EXIT_CODE -eq 0 ]; then
        BLOCKS=$(echo "$BLOCKCHAIN_INFO" | grep -o '"blocks": *[0-9]*' | grep -o '[0-9]*')
        HEADERS=$(echo "$BLOCKCHAIN_INFO" | grep -o '"headers": *[0-9]*' | grep -o '[0-9]*')
        
        if [ -n "$BLOCKS" ]; then
            echo "Daemon responded! Current Blocks: $BLOCKS | Headers: ${HEADERS:-0}"
            SYNC_SUCCESS=true
            break
        fi
    fi

    echo "Waiting for RPC interface to be ready... ($((RETRY_COUNT+1))/$MAX_RETRIES)"
    sleep 10
    RETRY_COUNT=$((RETRY_COUNT+1))
done

echo "=========================================="
if [ "$SYNC_SUCCESS" = true ]; then
    echo "Successfully installed gspcoin daemon!"
    exit 0
else
    echo "FAILURE: GSPCoin daemon failed to start syncing."
    echo ""
    echo "--- Systemd Service Status ---"
    systemctl status gspcoind --no-pager -l | tail -n 15
    echo ""
    echo "--- Last 25 lines of debug.log ---"
    if [ -f "$DATA_DIR/debug.log" ]; then
        tail -n 25 "$DATA_DIR/debug.log"
    else
        echo "debug.log not found in $DATA_DIR. Check journalctl -u gspcoind for startup errors."
    fi
    echo "=========================================="
    exit 1
fi
