#!/usr/bin/env bash
#
# start.sh — simple launcher for OGK-Pre Miller
# - runs the decrypted script automatically
# Requirements: openssl, python3

# Configuration
ENCFILE="ogkpremiller.enc"
OUTFILE="ogkpremiller.py"
PYTHON_BIN="python3"

# Colors (ANSI)
RED="\033[1;31m"
GRN="\033[1;32m"
YLW="\033[1;33m"
BLU="\033[1;34m"
MAG="\033[1;35m"
CYN="\033[1;36m"
RST="\033[0m"

# Clear screen and print header
clear
echo -e "${MAG}============================================================${RST}"
echo -e "${GRN}                 OGK-Pre Miller 👾 - APK Anylizer Tool ${RST}"
echo -e "${MAG}============================================================${RST}"
echo
echo -e "${YLW}Short description:${RST} OGK-Pre Miller provides a complete static analysis summary of an Android APK."
echo
echo -e "${CYN}Important:${RST} The decryption key is posted on our Telegram channel."
echo -e "${CYN}Telegram:${RST} ✈️  ${GRN}@CryptonicArea${RST}"
echo
# Prompt for key (hidden)
printf "${YLW}Enter Key - ${RST}"
read -s PASSWORD
echo
# Basic checks
if [ -z "$PASSWORD" ]; then
  echo -e "${RED}No key entered. Exiting.${RST}"
  exit 1
fi

if [ ! -f "$ENCFILE" ]; then
  echo -e "${RED}Error:${RST} Encrypted file '${ENCFILE}' not found."
  exit 2
fi

if ! command -v openssl >/dev/null 2>&1; then
  echo -e "${RED}Error:${RST} openssl not found. Install openssl and try again."
  exit 3
fi

if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
  echo -e "${RED}Error:${RST} python3 not found as '${PYTHON_BIN}'. Adjust PYTHON_BIN if needed."
  exit 4
fi

# Decrypt (AES-256-CBC with PBKDF2). Adjust options if you used different encryption params.
echo -e "${CYN}Decrypting...${RST}"
printf "%s" "$PASSWORD" | openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 -salt -pass stdin -in "$ENCFILE" -out "$OUTFILE" 2>/tmp/ogk_decrypt_err.$$
RC=$?

# Clear password from memory (best-effort)
PASSWORD=""
unset PASSWORD

if [ $RC -ne 0 ] || [ ! -s "$OUTFILE" ]; then
  echo -e "${RED}Decryption Failed [ Key Not Vaild].${RST}"
  if [ -s /tmp/ogk_decrypt_err.$$ ]; then
    echo -e "${YLW}OpenSSL message:${RST}"
    sed -n '1,6p' /tmp/ogk_decrypt_err.$$
  fi
  rm -f /tmp/ogk_decrypt_err.$$ 2>/dev/null || true
  exit 5
fi

# Basic sanity check: looks like a Python file?
head1=$(head -n 1 "$OUTFILE" 2>/dev/null | tr -d '\r\n' | cut -c1-80)
if ! echo "$head1" | grep -E -q "^\#\!|^import |^from |^def |^class " ; then
  # Try python compile check; if fails, warn but still allow run
  if ! python3 -m py_compile "$OUTFILE" >/dev/null 2>&1; then
    echo -e "${YLW}Warning:${RST} Decrypted file does not look like a valid Python script."
    echo -e "${YLW}Proceeding to run it anyway (you can inspect ${OUTFILE}).${RST}"
  fi
fi

# Run the decrypted Python script
echo -e "${GRN}Running ${OUTFILE}...${RST}"
"$PYTHON_BIN" "$OUTFILE"
EXITCODE=$?

echo
echo -e "${GRN}Finished. ${OUTFILE} is saved in the current directory.${RST}"
echo -e "${CYN}Reminder:${RST} Get Keys From Telegram: ✈️  ${GRN}@CryptonicArea${RST}"
exit $EXITCODE
