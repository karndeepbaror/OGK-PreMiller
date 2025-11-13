
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

*Clone the repository:*
```
git clone https://github.com/karndeepbaror/OGK-PreMiller.git
cd OGK-PreMiller
```
*Install Python packages:*
```
pip3 install -r requirements.txt
```

***Usage 🚀***

1. Run the launcher:
```
bash start.sh
```

3. You will see the tool banner:
```
============================================================
                 OGK-Pre Miller 👾 - Advanced APK Anylizer Tool 
============================================================

About: OGK-Pre Miller provides a complete static analysis summary of an Android APK.

Important: The decryption key is posted on our Telegram channel.
Telegram: ✈️  @CryptonicArea

Enter Key 🔐 -
```

3. Enter the key from our Telegram channel:
✈️ @CryptonicArea

4. Follow on-screen prompts to analyze your APK:

Enter the full path to your APK file:  
```
/storage/emulated/0/Download/sample.apk
```

View detailed report in terminal

Optionally save report as a text file


***Supported Platforms 💻***

__Termux / Android__
__Linux__
__macOS__
__Windows (Python 3)__


> Note: On Termux, make sure python3 and openssl are installed:
```
pkg install python openssl
```

***Security 🔒***

- The tool is password-protected. The key is shared only on Telegram: ✈️ @CryptonicArea

- The encrypted script cannot be redistributed.

- The decrypted Python file may be automatically deleted after execution (if using auto-delete version) for security.

***License 📜***

_This repository uses a Modified MIT License:_

_Normal MIT permissions apply to all non-encrypted scripts and helper files._

_The encrypted .enc file and Telegram key cannot be copied, modified, or redistributed._


"See the LICENSE file for details."

***Author 👨‍💻***

*Karndeep Baror - Passionate Ethical Hacker*
GitHub: github.com/karndeepbaror

