#!/usr/bin/env bash
#
# start.sh — launcher for OGK-Pre Miller
# Decrypts ogkpremiller.enc -> ogkpremiller.py and runs it.
# Keeps decrypted file
#
# Requirements: openssl, python3

ENCFILE="ogkpremiller.enc"
OUTFILE="ogkpremiller.py"
PYTHON_BIN="python3"

# Colors
RED="\033[1;31m"; GRN="\033[1;32m"; YLW="\033[1;33m"
BLU="\033[1;34m"; MAG="\033[1;35m"; CYN="\033[1;36m"
RST="\033[0m"

# Keep header/interface same as requested (clean & colored)
clear
echo -e "${MAG}============================================================${RST}"
echo -e "${GRN}                 OGK-Pre Miller 👾 - Adwanced APK Anylizer Tool${RST}"
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

# Temp file for openssl stderr
ERRTMP=$(mktemp /tmp/ogkerr.XXXXXX)

# Try decrypt with pbkdf2 first (stronger KDF). If fails, try without pbkdf2.
DECRYPT_OK=0

echo -e "${CYN}Decrypting (attempt 1: pbkdf2)...${RST}"
printf "%s" "$PASSWORD" | openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 -salt -pass stdin -in "$ENCFILE" -out "$OUTFILE" 2>"$ERRTMP"
RC=$?
if [ $RC -eq 0 ] && [ -s "$OUTFILE" ]; then
  DECRYPT_OK=1
else
  # remove any partial output
  rm -f "$OUTFILE" >/dev/null 2>&1 || true
  echo -e "${YLW}Attempt 1 failed, trying fallback (non-pbkdf2)...${RST}"
  printf "%s" "$PASSWORD" | openssl enc -d -aes-256-cbc -salt -pass stdin -in "$ENCFILE" -out "$OUTFILE" 2>"$ERRTMP"
  RC2=$?
  if [ $RC2 -eq 0 ] && [ -s "$OUTFILE" ]; then
    DECRYPT_OK=1
  else
    DECRYPT_OK=0
  fi
fi

# Clear password variable (best-effort)
PASSWORD=""
unset PASSWORD

# If decrypt failed -> show small message and exit
if [ $DECRYPT_OK -ne 1 ]; then
  echo -e "${RED}Decryption failed (wrong key or incompatible encryption options).${RST}"
  if [ -s "$ERRTMP" ]; then
    echo -e "${YLW}OpenSSL output:${RST}"
    sed -n '1,8p' "$ERRTMP"
  fi
  rm -f "$ERRTMP" >/dev/null 2>&1 || true
  rm -f "$OUTFILE" >/dev/null 2>&1 || true
  exit 5
fi

rm -f "$ERRTMP" >/dev/null 2>&1 || true

# Quick sanity check: looks like Python?
head1=$(head -n 1 "$OUTFILE" 2>/dev/null | tr -d '\r\n' | cut -c1-80)
if ! echo "$head1" | grep -E -q "^\#\!|^import |^from |^def |^class " ; then
  # try compile check
  if python3 -m py_compile "$OUTFILE" >/dev/null 2>&1; then
    echo -e "${GRN}Decryption successful (syntax ok).${RST}"
  else
    echo -e "${YLW}Warning:${RST} Decrypted file does not look like a standard Python script, but will attempt to run it."
  fi
else
  echo -e "${GRN}Decryption successful.${RST}"
fi

# Run the decrypted Python script
echo -e "${GRN}Running ${OUTFILE}...${RST}"
"$PYTHON_BIN" "$OUTFILE"
EXITCODE=$?

echo
echo -e "${GRN}Finished. ${OUTFILE} is saved in the current directory.${RST}"
echo -e "${CYN}Reminder:${RST} Get keys from Telegram: ✈️  ${GRN}@CryptonicArea${RST}"
exit $EXITCODE
