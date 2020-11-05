#!/usr/bin/env bash


# Client configuration
CLIENT_PEM="./client.pem"
SERVER_CRT="./server.crt"
SERVER_ADDR="0.0.0.0:0"

# Connect to server and communicate through stdio
socat openssl-connect:$SERVER_ADDR,cert=$CLIENT_PEM,cafile=$SERVER_CRT stdio
