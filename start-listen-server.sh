#!/usr/bin/env bash


# Server configuration
CLIENT_CRT="./client.crt"
SERVER_PEM="./server.pem"
BIND_ADDR="127.0.0.1"
LISTEN_PORT=0

# Auto-detect LAN IP
LAN_ADDR=$(hostname -I | cut -d " " -f 1)

# Pick between localhost and LAN/public IP
read -n 1 -p "Would you like to bind to $LAN_ADDR instead of $BIND_ADDR? "; echo
if [ "$REPLY" == "y" ]; then
	BIND_ADDR=$LAN_ADDR
	echo "Bind address set to $BIND_ADDR"
fi

# Start listen server in tmux and communicate through stdio
tmux new -s "socat-ssl-server" "socat -dd openssl-listen:$LISTEN_PORT,bind=$BIND_ADDR,reuseaddr,fork,cert=$SERVER_PEM,cafile=$CLIENT_CRT stdio"
