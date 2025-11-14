import os
import sys
import subprocess
import getpass
import base64
import tempfile

# ---------- INTERFACE ----------
def banner():
    os.system("clear")
    print("\033[1;96m" + "="*60)
    print("               OGK-PRE MILLER")
    print("="*60 + "\033[0m")
    print("\033[1;93mA powerful encrypted tool loader for secure execution.\033[0m")
    print("\033[1;92mEncrypted file   : ogkpremiller.enc")
    print("\033[1;92mPassword source  : Telegram Channel")
    print("\033[1;96mTelegram :  @CryptonicArea\033[0m")
    print("\n\033[1;95mPress ENTER to continue...\033[0m")
    input()


# ---------- DECRYPT USING OPENSSL ----------
def decrypt_with_openssl(password):
    enc_file = "ogkpremiller.enc"

    if not os.path.exists(enc_file):
        print("\033[1;91mEncrypted file 'ogkpremiller.enc' not found!\033[0m")
        sys.exit(1)

    try:
        # Temporary file to store decrypted output
        tmp = tempfile.NamedTemporaryFile(delete=False, suffix=".py")
        tmp_path = tmp.name
        tmp.close()

        # Run OpenSSL decryption
        result = subprocess.run(
            [
                "openssl", "enc", "-aes-256-cbc", "-d",
                "-base64",
                "-in", enc_file,
                "-out", tmp_path,
                "-pass", f"pass:{password}"
            ],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )

        # If wrong password
        if result.returncode != 0:
            os.remove(tmp_path)
            return None

        return tmp_path

    except Exception as e:
        print("\033[1;91mERROR decrypting file:\033[0m", e)
        return None


# ---------- MAIN ----------
def main():
    banner()

    print("\033[1;93mEnter password to decrypt the tool:\033[0m")
    password = getpass.getpass("> ")

    print("\n\033[1;96mDecrypting... Please wait...\033[0m")

    decrypted_file = decrypt_with_openssl(password)

    if decrypted_file is None:
        print("\033[1;91mInvalid password! Decryption failed.\033[0m")
        sys.exit(1)

    print("\033[1;92mDecryption Success! Running tool...\033[0m\n")

    # Run decrypted python code
    os.system(f"python {decrypted_file}")

    # Optional: Delete decrypted file after execution
    os.remove(decrypted_file)


if __name__ == "__main__":
    main()
