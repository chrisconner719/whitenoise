#!/usr/bin/env bash


FILENAME=$1

# Create private RSA key
openssl genrsa -out $FILENAME.key 8192

# Create X509 certificate, valid for one year
openssl req -new -key $FILENAME.key -x509 -days 365 -out $FILENAME.crt

# Resulting pem file is secret!
cat $FILENAME.key $FILENAME.crt >$FILENAME.pem

# Set permissions on private keys
chmod 600 $FILENAME.key $FILENAME.pem

echo -e "\nSecurely transfer $FILENAME.crt to the other peer."
