import base64
import hashlib
import os
from Crypto.Cipher import AES

# UI
def banner():
    os.system("clear")
    print("==========================================")
    print("[ OGK PREMILLER ] - Secure Loader")
    print("==========================================")
    print("Encrypted module detected: ogkpremiller.enc")
    print("Enter correct key to unlock.\n")

def openssl_key_iv(password, salt, key_len=32, iv_len=16):
    """
    OpenSSL compatible EVP_BytesToKey algorithm
    """
    dt = b''
    prev = b''
    while len(dt) < key_len + iv_len:
        prev = hashlib.md5(prev + password + salt).digest()
        dt += prev
    return dt[:key_len], dt[key_len:key_len+iv_len]

def decrypt_openssl(enc_data, password):
    raw = base64.b64decode(enc_data)

    if raw[:8] != b"Salted__":
        raise ValueError("Invalid OpenSSL encrypted data (missing Salted__ header)")

    salt = raw[8:16]
    ciphertext = raw[16:]

    key, iv = openssl_key_iv(password.encode(), salt)

    cipher = AES.new(key, AES.MODE_CBC, iv)
    decrypted = cipher.decrypt(ciphertext)

    pad_len = decrypted[-1]
    return decrypted[:-pad_len]

# MAIN
if __name__ == "__main__":
    banner()

    if not os.path.exists("ogkpremiller.enc"):
        print("ERROR: Encrypted file 'ogkpremiller.enc' not found!")
        exit()

    with open("ogkpremiller.enc", "r") as f:
        encrypted_content = f.read()

    password = input("Enter Decryption Key: ")

    print("\nValidating key...\n")

    try:
        decrypted_code = decrypt_openssl(encrypted_content, password)
        print("[✔] Key accepted!")
        print("[✔] Loading OGK Premiller...\n")

        exec(decrypted_code.decode())

    except Exception as e:
        print("[✘] Wrong key or corrupted file!")
        print(f"Error: {e}")
