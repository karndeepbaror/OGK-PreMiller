
# OGK-Pre Miller 👾 

**OGK-Pre Miller** is an advanced **Android APK Analyzer Tool** designed to provide **complete static analysis** of any Android APK.  
It extracts detailed information about an APK’s technologies, languages, frameworks, and more, helping security researchers, pen-testers, and developers understand APK internals quickly.


## Features ✨

- Analyze Android APKs for:
  - Programming languages used
  - Frameworks and SDKs
  - Manifest permissions
  - Assets and resources
  - Approximate code structure & file types
- Generates a detailed report in terminal
- Option to save analysis results to a text file
- Professional launcher interface with colored prompts
- Password-protected access via Telegram channel
- Runs on **Termux / Linux / macOS / Windows (Python 3)**


## Installation ⚙️

**Requirements:**
- Python 3.8+  
- OpenSSL (for decryption)  
- Required Python packages: see below  

**Step 1 — Install dependencies**

Clone the repository:
```bash
git clone https://github.com/karndeepbaror/OGK-PreMiller.git
cd OGK-PreMiller

Install Python packages:

python3 -m pip install --upgrade pip setuptools wheel
python3 -m pip install -r requirements.txt

or

python3 setup.py install


Usage 🚀

1. Run the launcher:



./start.sh

2. You will see the tool banner:



OGK-Pre Miller
Short description: Provides full APK analysis.

3. Enter the key from our Telegram channel:
✈️ @CryptonicArea


4. The encrypted Python script (ogkpremiller.enc) will be decrypted automatically to ogkpremiller.py and executed.


5. Follow on-screen prompts to analyze your APK:

Enter the full path to your APK file (e.g., /storage/emulated/0/Download/sample.apk)

View detailed report in terminal

Optionally save report as a text file





Supported Platforms 💻

Termux / Android

Linux

macOS

Windows (Python 3)


> Note: On Termux, make sure python3 and openssl are installed:



pkg install python openssl



Security 🔒

The tool is password-protected. The key is shared only on Telegram: ✈️ @CryptonicArea

The encrypted script cannot be redistributed.

The decrypted Python file may be automatically deleted after execution (if using auto-delete version) for security.



License 📜

This repository uses a Modified MIT License:

Normal MIT permissions apply to all non-encrypted scripts and helper files.

The encrypted .enc file and Telegram key cannot be copied, modified, or redistributed.


See the LICENSE file for details.


Author 👨‍💻

Karndeep Baror
GitHub: github.com/karndeepbaror

