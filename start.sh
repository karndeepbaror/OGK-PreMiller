#!/bin/bash

# Colors
red="\e[91m"
green="\e[92m"
yellow="\e[93m"
cyan="\e[96m"
reset="\e[0m"

clear

echo -e "$cyan"
echo "╔──────────────────────────────────────────╗"
echo "│           OGK - PRE MILLER              │"
echo "│        Advanced APK Intelligence         │"
echo "╚──────────────────────────────────────────╝"
echo -e "$reset"

echo -e "$green Developer  : Karndeep Baror$reset"
echo -e "$green Github     : github.com/karndeepbaror$reset"
echo
echo -e "$yellow Description:$reset"
echo -e "$cyan This tool decrypts and launches the OGK-PreMiller APK analysis engine."
echo -e "It extracts deep technical information from any APK file.$reset"
echo
echo -e "$red NOTE:$reset Password is available on our Telegram channel."
echo -e "$cyan Telegram: 🔷 @CryptonicArea $reset"
echo
echo -e "$yellow──────────────────────────────────────────────$reset"
echo -ne "$green Enter Key: $reset"
read -r KEY

echo
echo -e "$yellow[+] Checking for OpenSSL...$reset"

# TERMUX FIX – detect both openssl-tool & openssl
if command -v openssl >/dev/null 2>&1; then
    OPENSSL_BIN=$(command -v openssl)
elif [ -f "/data/data/com.termux/files/usr/bin/openssl" ]; then
    OPENSSL_BIN="/data/data/com.termux/files/usr/bin/openssl"
else
    echo -e "$red[!] OpenSSL not installed.$reset"
    echo -e "$yellowInstall it using:$reset"
    echo -e "$cyan pkg install openssl-tool -y $reset"
    exit 1
fi

echo -e "$green[✓] OpenSSL Found: $OPENSSL_BIN$reset"
echo
echo -e "$yellow[+] Decrypting ogkpremiller.enc ...$reset"

# Check if encrypted file exists
if [ ! -f "ogkpremiller.enc" ]; then
    echo -e "$red[!] Encrypted file 'ogkpremiller.enc' not found.$reset"
    exit 1
fi

# Decrypt command
$OPENSSL_BIN enc -aes-256-cbc -d -in ogkpremiller.enc -out ogkpremiller.py -k "$KEY" 2>/dev/null

# If decrypt fails
if [ $? -ne 0 ]; then
    echo -e "$red[!] Incorrect key. Decryption failed.$reset"
    exit 1
fi

echo -e "$green[✓] File successfully decrypted → ogkpremiller.py$reset"
echo -e "$yellow[+] Launching tool...$reset"
sleep 1
echo

# Run decrypted tool
python3 ogkpremiller.py
