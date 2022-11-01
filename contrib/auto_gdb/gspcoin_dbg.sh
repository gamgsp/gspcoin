#!/bin/bash
# use testnet settings,  if you need mainnet,  use ~/.gspcoincore/gspcoind.pid file instead
gspcoin_pid=$(<~/.gspcoincore/testnet3/gspcoind.pid)
sudo gdb -batch -ex "source debug.gdb" gspcoind ${gspcoin_pid}
