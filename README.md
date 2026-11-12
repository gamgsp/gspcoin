# GSP Coin

<div align="center">
  <img src="https://github.com/gamgsp/globaldata/blob/main/GSP%20Coin/gspcname%20black2.png?raw=true" alt="GSP Coin Logo" width="160" />
  <br />
  <strong>Decentralized Layer-1 Proof-of-Work Blockchain Fueling Next-Generation Digital Advertising, DeFi & Global Commercial Utility</strong>
  <br /><br />

  [![Release](https://img.shields.io/github/v/release/gamgsp/gspcoin?color=blue&style=flat-square)](https://github.com/gamgsp/gspcoin/releases)
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)
  [![Network](https://img.shields.io/badge/Mainnet-Active-success?style=flat-square)](https://explorer.gspcoin.us)
  [![Discord](https://img.shields.io/badge/Discord-Join%20Community-7289DA?style=flat-square&logo=discord)](https://discord.gg/Anh2sr4txV)
  [![Telegram](https://img.shields.io/badge/Telegram-Chat-0088cc?style=flat-square&logo=telegram)](https://t.me/gspc_gspcoin)
  [![Twitter](https://img.shields.io/badge/Twitter-Follow-1DA1F2?style=flat-square&logo=twitter)](https://x.com/gspcoin)
</div>

---

## Table of Contents
- [1. Overview](#1-overview)
- [2. Key Technical Specifications](#2-key-technical-specifications)
- [3. GhostRider PoW Algorithm & Smartnode Consensus](#3-ghostrider-pow-algorithm--smartnode-consensus)
- [4. Automated Node & Daemon Setup (`gspcdaemon.sh`)](#4-automated-node--daemon-setup-gspcdaemonsh)
  - [What the Script Does](#what-the-script-does)
  - [Quick Install Commands](#quick-install-commands)
  - [Managing the Daemon After Installation](#managing-the-daemon-after-installation)
- [5. Manual Compilation & Building from Source](#5-manual-compilation--building-from-source)
- [6. Official Network Links & Explorers](#6-official-network-links--explorers)
- [7. Parent Company & Commercial Subsidiaries Matrix](#7-parent-company--commercial-subsidiaries-matrix)
  - [Global Ads Media, LLC (Parent Organization)](#global-ads-media-llc-parent-organization)
  - [Commercial Subsidiaries & GSPC Utility Integration](#commercial-subsidiaries--gspc-utility-integration)
- [8. License & Development Process](#8-license--development-process)

---

## 1. Overview

**GSP Coin (GSPC)** is an enterprise-grade, decentralized Layer-1 cryptocurrency linking blockchain technology directly to the multi-billion-dollar digital advertising, programmatic AdTech, and online media industries.

Developed by **Global Ads Media, LLC**, GSP Coin powers an interconnected commercial ecosystem. Advertisers, publishers, software subscribers, and retail traders utilize GSPC for automated campaign settlements, real-time programmatic bidding (RTB), high-yield Smartnode validator staking, cloud hosting, and decentralized peer-to-peer exchange services.

By combining an ASIC/FPGA-resistant Proof-of-Work hashing algorithm (**GhostRider**) with deterministic **Smartnode Collateralized Quorums (LLMQ)** and **ChainLocks**, GSP Coin guarantees 51% attack immunity, sub-second transaction finality via InstantSend, and confidential financial settlements through integrated CoinJoin privacy.

---

## 2. Key Technical Specifications

| Parameter | Specification |
| :--- | :--- |
| **Coin Name / Ticker** | GSP Coin (`GSPC`) |
| **Blockchain Architecture** | Native Layer-1 UTXO |
| **Consensus Mechanism** | Proof-of-Work (PoW) + Proof-of-Service Smartnodes |
| **Hashing Algorithm** | **GhostRider** (CPU & GPU Friendly; ASIC/FPGA Resistant) |
| **Block Time** | 240 seconds (4 minutes) |
| **Difficulty Retargeting** | Dark Gravity Wave v3 (Every block) |
| **Smartnode Collateral** | Tiered collateral (Validator staking & ChainLocks) |
| **51% Attack Protection** | **ChainLocks** via Long-Living Masternode Quorums (LLMQ) |
| **Instant Transactions** | **InstantSend** (Deterministic sub-second lockups) |
| **Privacy Technology** | Decentralized on-chain **CoinJoin** mixing in core wallet |
| **P2P Port** | `15168` (Testnet: `15169`) |
| **RPC Port** | `15167` (Testnet: `15170`) |
| **ElectrumX Ports** | TCP: `50001` \| SSL: `50002` \| WSS: `50003` |

---

## 3. GhostRider PoW Algorithm & Smartnode Consensus

GSP Coin utilizes the **GhostRider** algorithm to protect the network from centralized industrial mining farms, specialized Application-Specific Integrated Circuits (ASICs), and field-programmable arrays (FPGAs):
- **Cryptographic Permutations:** GhostRider dynamically cycles through randomized combinations of hashing algorithms (including X16R variants, CryptoNight, Blake, Keccak, SHA-512, Skein, and Cubehash) with fluctuating memory load requirements.
- **Fair Hardware Accessibility:** Enables individual community members and miners to profitably participate using consumer-grade desktop CPUs (AMD Ryzen, Intel Core) and modern GPUs.
- **Smartnode Network Protection (ChainLocks):** Deterministically chosen LLMQ quorums validate and sign blocks as soon as they are mined. Once a block receives a ChainLock signature, it cannot be reorganized, completely neutralizing double-spend and 51% mining attacks.

---

# GSPCoin (`gspcoind`) — Node & Daemon Setup Guide

This guide covers automated installation on **Linux** and **macOS** using `gspcdaemon.sh`, as well as manual setup instructions for **Windows**.

---

## Linux & macOS (Automated Script)

The `gspcdaemon.sh` script automates the complete setup of a **GSPCoin (`gspcoind`)** node on **Linux** (Ubuntu, Debian, RHEL/CentOS/AlmaLinux/Rocky, Fedora, Arch, openSUSE) and **macOS** (Intel & Apple Silicon).

### What the Script Does
1. **OS & Architecture Detection:** Automatically detects your operating system and CPU architecture (`x86_64` or `arm64`) and installs required dependencies (`curl`, `wget`, `unzip`, `tar`).
2. **Swap Configuration (Linux):** Creates and enables a persistent **2GB swapfile** (`/swapfile`) if one is not already active.
3. **Binary Installation:** Fetches the matching `v2.2.2` release binary from GitHub, extracts `gspcoind` and `gspcoin-cli`, and installs them into `/usr/local/bin`.
4. **Interactive RPC Configuration:** Prompts you to set a custom `rpcuser` and `rpcpassword`, generates `gspcoin.conf` with full indexing (`txindex=1`, `addressindex=1`, `spentindex=1`), and pre-populates active seed nodes.
5. **Bootstrap Snapshot:** Downloads and extracts the latest blockchain bootstrap snapshot into your OS's native data directory, then deletes the downloaded archive files to save disk space:
   - **Linux:** `~/.gspcoincore/`
   - **macOS:** `~/Library/Application Support/GSPCoinCore/` (automatically symlinked to `~/.gspcoincore/`)
6. **Background Service Setup:** Registers and starts `gspcoind` as a background service (`systemd` on Linux, `launchd` on macOS) so it starts automatically on boot.
7. **Sync Verification:** Verifies live RPC connectivity and block synchronization via `gspcoin-cli getblockchaininfo` (or prints diagnostic logs from `debug.log` if startup fails).

### Quick Install Commands

#### 1. Standard Linux (Ubuntu, Debian, CentOS/RHEL, AlmaLinux, Rocky, Fedora, Arch, openSUSE)
**When to use:** Use this on any standard Linux VPS or dedicated server where you are logged in as a regular user with `sudo` privileges (or as `root` with `curl` installed).

```bash
curl -fsSL [https://raw.githubusercontent.com/gamgsp/gspcoin/master/gspcdaemon.sh](https://raw.githubusercontent.com/gamgsp/gspcoin/master/gspcdaemon.sh) -o gspcdaemon.sh && chmod +x gspcdaemon.sh && sudo ./gspcdaemon.sh && rm -f gspcdaemon.sh
```

#### 2. Minimal Linux Fallback (No `curl` or `sudo` Pre-Installed)
**When to use:** Use this on bare-bones cloud images (such as minimal Ubuntu/Debian containers or fresh VPS installs) where `curl` or `sudo` is missing and you are logged in directly as `root`.

```bash
wget -qO gspcdaemon.sh [https://raw.githubusercontent.com/gamgsp/gspcoin/master/gspcdaemon.sh](https://raw.githubusercontent.com/gamgsp/gspcoin/master/gspcdaemon.sh) && chmod +x gspcdaemon.sh && ./gspcdaemon.sh && rm -f gspcdaemon.sh
```

#### 3. macOS (Intel & Apple Silicon M1/M2/M3/M4)
**When to use:** Use this in your macOS Terminal. Run it as your **normal macOS user** (do **not** prefix the command with `sudo`; the script will prompt for your password only when copying binaries into `/usr/local/bin`).

```bash
curl -fsSL [https://raw.githubusercontent.com/gamgsp/gspcoin/master/gspcdaemon.sh](https://raw.githubusercontent.com/gamgsp/gspcoin/master/gspcdaemon.sh) -o gspcdaemon.sh && chmod +x gspcdaemon.sh && ./gspcdaemon.sh && rm -f gspcdaemon.sh
```

> **Note for Apple Silicon Macs:** If the `v2.2.2` release provides an Intel (`x86_64`) macOS binary, ensure Rosetta 2 is installed (`softwareupdate --install-rosetta --agree-to-license`) before running the script.

> **Security Note:** During installation, you will be prompted to enter your desired **RPC Username** and **RPC Password**. Your password input is hidden while typing and saved with `chmod 600` permissions inside `gspcoin.conf`.

---

## Windows (Manual Setup)

Follow these steps to download, configure, bootstrap, and run the GSPCoin daemon on **Windows 10 / Windows 11 / Windows Server**:

### Step 1: Download the Windows Binaries & Bootstrap Snapshot
1. Go to the [GSPCoin v2.2.2 Releases Page](https://github.com/gamgsp/gspcoin/releases/tag/v2.2.2).
2. Download the **Windows release zip** (e.g., `gspcoin-win64-2.2.2.zip` or `gspcoin-windows-...zip`).
3. Download the **Bootstrap Snapshot**: `Bootstrap-Snapshot-24-Oct-2026.zip`.

### Step 2: Extract the GSPCoin Program Files
1. Create a folder on your `C:\` drive named `C:\GSPCoin`.
2. Right-click the downloaded Windows release `.zip` file, click **Extract All...**, and extract its contents into `C:\GSPCoin`.
3. Ensure `gspcoind.exe` and `gspcoin-cli.exe` (and `gspcoin-qt.exe` if included) are located inside `C:\GSPCoin` (or `C:\GSPCoin\bin`).

### Step 3: Create the Data Directory & `gspcoin.conf`
1. Press `Win + R` on your keyboard, type `%APPDATA%`, and press **Enter**.
2. Create a new folder named `GSPCoinCore` (full path: `C:\Users\<YourUsername>\AppData\Roaming\GSPCoinCore`).
3. Open **Notepad**, paste the configuration below (replace `YOUR_RPC_USERNAME` and `YOUR_RPC_PASSWORD` with your own credentials), and save it inside `GSPCoinCore` as `gspcoin.conf` *(set "Save as type" to **All Files (*.*)** so Windows does not save it as `gspcoin.conf.txt`)*:

```ini
rpcuser=YOUR_RPC_USERNAME
rpcpassword=YOUR_RPC_PASSWORD
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
```

### Step 4: Extract the Bootstrap Snapshot
1. Right-click `Bootstrap-Snapshot-24-Oct-2026.zip` and choose **Extract All...**.
2. Set the destination path to `%APPDATA%\GSPCoinCore` (so that the `blocks` and `chainstate` folders sit directly inside `C:\Users\<YourUsername>\AppData\Roaming\GSPCoinCore`).
3. Once extraction finishes, you may delete both downloaded `.zip` files to free up disk space.

### Step 5: Start & Verify the Daemon
1. Open **Command Prompt (cmd)** or **PowerShell** and navigate to your GSPCoin folder:
   ```cmd
   cd C:\GSPCoin
   ```
   *(If the executables are inside a `bin` subfolder, run `cd C:\GSPCoin\bin` instead.)*
2. Start the daemon:
   ```cmd
   gspcoind.exe -daemon
   ```
   *(Note: If your Windows build runs in the foreground instead of detaching with `-daemon`, leave that terminal window open and open a second Command Prompt window for the commands below.)*
3. Wait 15–30 seconds for initialization, then check sync status:
   ```cmd
   gspcoin-cli.exe getblockchaininfo
   ```
4. To safely stop the daemon on Windows at any time:
   ```cmd
   gspcoin-cli.exe stop
   ```

> **Optional — Auto-Start on Windows Boot:** Press `Win + R`, type `shell:startup`, and press **Enter**. Create a shortcut to `C:\GSPCoin\gspcoind.exe` inside that Startup folder so the daemon launches automatically whenever you sign in to Windows.

---

## Managing the Daemon After Installation

### Check Sync & Blockchain Status
* **Linux / macOS:** `gspcoin-cli getblockchaininfo`
* **Windows:** `gspcoin-cli.exe getblockchaininfo`

### Check Connected Peers
* **Linux / macOS:** `gspcoin-cli getnetworkinfo`
* **Windows:** `gspcoin-cli.exe getnetworkinfo`

### Service Management Commands

* **Linux (`systemd`):**
  ```bash
  sudo systemctl status gspcoind    # Check service status
  sudo systemctl restart gspcoind   # Restart daemon
  sudo systemctl stop gspcoind      # Stop daemon
  ```

* **macOS (`launchd`):**
  ```bash
  launchctl list | grep gspcoin                                         # Check service status
  launchctl unload ~/Library/LaunchAgents/com.gspcoin.gspcoind.plist    # Stop daemon
  launchctl load -w ~/Library/LaunchAgents/com.gspcoin.gspcoind.plist   # Start daemon
  ```

---

## 5. Manual Compilation & Building from Source

For developers and node operators wishing to build GSPCoin from source code on Linux/Unix:

```bash
# Clone the repository
git clone https://github.com/gamgsp/gspcoin.git
cd gspcoin

# Install dependencies (Ubuntu/Debian)
sudo apt-get update
sudo apt-get install -y build-essential libtool autotools-dev automake pkg-config \
    bsdmainutils python3 libssl-dev libevent-dev libboost-system-dev libboost-filesystem-dev \
    libboost-chrono-dev libboost-test-dev libboost-thread-dev libdb5.3++-dev libdb5.3++ \
    libminiupnpc-dev libzmq3-dev

# Generate build configuration and compile
./autogen.sh
./configure --disable-tests --without-gui
make -j$(nproc)

# Install binaries into /usr/local/bin
sudo make install
```

---

## 6. Official Network Links & Explorers

- **Official Website:** [https://gspcoin.us](https://gspcoin.us)
- **Primary Block Explorer:** [https://explorer.gspcoin.us](https://explorer.gspcoin.us)
- **Secondary Explorer Mirror:** [https://explorer.globalsocialpost.com](https://explorer.globalsocialpost.com)
- **GSPC P2P Escrow Exchange:** [https://exchange.gspcoin.us](https://exchange.gspcoin.us)
- **Official Whitepaper:** [https://gspcoin.us/whitepaper](https://gspcoin.us/whitepaper)
- **Documentation & Knowledge Centre:** [https://gspcoin.us/docs](https://gspcoin.us/docs)
- **GitHub Repository:** [https://github.com/gamgsp/gspcoin](https://github.com/gamgsp/gspcoin)
- **Community Discord:** [https://discord.gg/Anh2sr4txV](https://discord.gg/Anh2sr4txV)
- **Community Telegram:** [https://t.me/gspc_gspcoin](https://t.me/gspc_gspcoin)
- **Official Twitter / X:** [https://x.com/gspcoin](https://x.com/gspcoin)

---

## 7. Parent Company & Commercial Subsidiaries Matrix

GSP Coin is backed and continuously utilized by **Global Ads Media, LLC** and its network of seven active commercial tech subsidiaries, creating a closed-loop economic ecosystem with organic utility, recurring transaction velocity, and continuous token burn mechanics.

### Global Ads Media, LLC (Parent Organization)
<p align="center">
  <a href="https://globaladsmedia.us" target="_blank">
    <img src="https://github.com/gamgsp/globaldata/blob/main/Global%20Ads%20Media/globaladsmedia-black-300-90.png?raw=true" alt="Global Ads Media" width="220" />
  </a>
</p>

* **Website:** [https://globaladsmedia.us](https://globaladsmedia.us)
* **Sector:** Enterprise Digital Marketing, AdTech Infrastructure & Global Traffic Aggregation
* **Role in GSPC Ecosystem:** Global Ads Media operates automated programmatic advertising, high-volume Real-Time Bidding (RTB), and audience segmentation engines. Global Ads Media uses GSPC as an institutional clearing instrument for advertiser billing and publisher payouts, driving high-volume merchant settlements and reducing payment processing fees.

---

### Commercial Subsidiaries & GSPC Utility Integration

<table>
  <thead>
    <tr>
      <th width="180">Subsidiary</th>
      <th width="140">Sector</th>
      <th>Commercial Description & GSPC Utility</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center">
        <a href="https://1dollarcloud.com" target="_blank">
          <img src="https://github.com/gamgsp/globaldata/blob/main/1dollarcloud/1dollarcloud-black-300-60.png?raw=true" alt="1 Dollar Cloud" width="130" /><br />
          <strong>1 Dollar Cloud</strong>
        </a>
      </td>
      <td><strong>Cloud & VPS Infrastructure</strong></td>
      <td>
        <strong>Website:</strong> <a href="https://1dollarcloud.com">1dollarcloud.com</a><br />
        Enterprise-grade NVMe shared hosting, scalable Cloud VPS, dedicated bare-metal infrastructure, SSL certificates, and domain registration starting at $1.00/month.<br />
        <strong>GSPC Utility:</strong> 15% billing discount when paid in GSPC. Provides 1-click pre-configured hosting images for GSPC Smartnodes, driving recurring monthly retail demand.
      </td>
    </tr>
    <tr>
      <td align="center">
        <a href="https://globaltradepulse.com" target="_blank">
          <img src="https://github.com/gamgsp/globaldata/blob/main/Global%20Trade%20Pulse/gtp-logo-black.png" alt="Global Trade Pulse" width="130" /><br />
          <strong>Global Trade Pulse</strong>
        </a>
      </td>
      <td><strong>Quantitative Intelligence</strong></td>
      <td>
        <strong>Website:</strong> <a href="https://globaltradepulse.com">globaltradepulse.com</a><br />
        Real-time financial intelligence scanner tracking US Equities (NYSE/NASDAQ), Indian Markets (NSE/BSE), European indexes, and Spot Gold (XAUUSD) with ORB breakout and VWAP telemetry.<br />
        <strong>GSPC Utility:</strong> Institutional-grade quantitative API feeds and real-time algorithmic trade alerts are unlocked exclusively via tiered GSPC staking lockups.
      </td>
    </tr>
    <tr>
      <td align="center">
        <a href="https://exchange.gspcoin.us" target="_blank">
          <img src="https://github.com/gamgsp/globaldata/blob/main/GSPC%20Exchange/gspcexc-dark-logo.png?raw=true" alt="GSPC Exchange" width="130" /><br />
          <strong>GSPC Exchange</strong>
        </a>
      </td>
      <td><strong>DeFi & P2P Trading</strong></td>
      <td>
        <strong>Website:</strong> <a href="https://exchange.gspcoin.us">exchange.gspcoin.us</a><br />
        Next-generation non-custodial P2P spot crypto market and automated on-chain escrow supporting 52+ trading pairs across 21 major digital assets.<br />
        <strong>GSPC Utility:</strong> Primary base pair asset. 0.5% flat trading fee with a 50% discount (to 0.25%) when paying fees in GSPC. 100% of accumulated GSPC trading fees are burned on-chain.
      </td>
    </tr>
    <tr>
      <td align="center">
        <a href="https://tryyourluck.today" target="_blank">
          <img src="https://github.com/gamgsp/globaldata/blob/main/Try%20Your%20Luck/tryyourluck-logo.png?raw=true" alt="TryYourLuck" width="130" /><br />
          <strong>TryYourLuck</strong>
        </a>
      </td>
      <td><strong>Digital Goods & Draws</strong></td>
      <td>
        <strong>Website:</strong> <a href="https://tryyourluck.today">tryyourluck.today</a><br />
        $1.00 consumer digital software marketplace (e.g., Email Cleaner Desktop Suite) bundled with guaranteed bonus tickets into provably fair prize draws with verified physical delivery.<br />
        <strong>GSPC Utility:</strong> Micro-transactions for digital downloads and raffle ticket entries settle seamlessly in GSPC without credit card processing fees or merchant chargebacks.
      </td>
    </tr>
    <tr>
      <td align="center">
        <a href="https://1url.my" target="_blank">
          <img src="https://github.com/gamgsp/globaldata/blob/main/1url/1url-black-1024-380.png?raw=true" alt="1url" width="130" /><br />
          <strong>1url</strong>
        </a>
      </td>
      <td><strong>Enterprise SaaS & Links</strong></td>
      <td>
        <strong>Website:</strong> <a href="https://1url.my">1url.my</a><br />
        Enterprise URL shortener, branded vanity domains, QR code generation, and traffic monetization engine for publishers, marketing agencies, and content creators.<br />
        <strong>GSPC Utility:</strong> Enterprise API subscriptions and custom domain tiers are billed in GSPC. Publisher link monetization payouts are disbursed in GSPC for instant global delivery.
      </td>
    </tr>
    <tr>
      <td align="center">
        <a href="https://worldnewsguru.us" target="_blank">
          <img src="https://github.com/gamgsp/globaldata/blob/main/World%20News%20Guru/wnglogo-black-512-167.png?raw=true" alt="World News Guru" width="130" /><br />
          <strong>World News Guru</strong>
        </a>
      </td>
      <td><strong>Global Journalism</strong></td>
      <td>
        <strong>Website:</strong> <a href="https://worldnewsguru.us">worldnewsguru.us</a><br />
        Premier digital journalism and international news publication delivering breaking world news, geopolitical reporting, financial coverage, and investigative journalism.<br />
        <strong>GSPC Utility:</strong> Reader micro-tipping for investigative journalists, exclusive editorial paywall unlocking, and sponsored article placements purchased via GSPC with on-chain verification.
      </td>
    </tr>
    <tr>
      <td align="center">
        <a href="https://globalcricinfo.com" target="_blank">
          <img src="https://github.com/gamgsp/globaldata/blob/main/Global%20Cric%20Info/global%20cric%20info%20logo%20black.png?raw=true" alt="Global Cric Info" width="130" /><br />
          <strong>Global Cric Info</strong>
        </a>
      </td>
      <td><strong>Sports Media & Analytics</strong></td>
      <td>
        <strong>Website:</strong> <a href="https://globalcricinfo.com">globalcricinfo.com</a><br />
        International sports media platform covering worldwide cricket tournaments (ICC, IPL, BBL, PSL, Ashes) with real-time ball-by-ball commentary, match telemetry, and statistics.<br />
        <strong>GSPC Utility:</strong> Powers interactive cricket fan engagement, fantasy tournament prediction leagues, and sports analytics subscriptions settled exclusively in GSPC.
      </td>
    </tr>
  </tbody>
</table>

---

## 8. License & Development Process

GSP Coin Core is open-source software released under the terms of the **[MIT License](COPYING)**.

- **Master Branch:** The `master` branch is stable and reflects official tagged production releases.
- **Contributions & Pull Requests:** Community developers are invited to submit bug fixes, documentation improvements, and optimizations via pull requests following [CONTRIBUTING.md](CONTRIBUTING.md).
- **Testing:** Unit tests can be compiled and run with `make check`. Functional Python tests are available in `test/functional/test_runner.py`.
