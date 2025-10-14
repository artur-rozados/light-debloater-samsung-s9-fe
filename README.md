# Galaxy Tab S9 FE Debloat Script

A simple shell script to remove bloatware and unnecessary apps from the Samsung Galaxy Tab S9 FE (SM-X510), helping to improve performance and save battery life.

## ⚠️ Disclaimer

This script was created for my own personal use and it worked on my device. **Use it at your own risk.** I am not responsible for any issues that may occur.

**IMPORTANT NOTE:** This script **completely REMOVES BIXBY**. If you use the Samsung assistant, either **do not run this script** or manually edit the script file to remove the Bixby-related lines under `[STEP 6]`.

## What does it remove?

The script focuses on removing:
* **Telemetry:** Data collectors from both Samsung and Google.
* **Partner Apps:** Microsoft OneDrive and other pre-installed third-party apps.
* **AR Junk:** All apps and services related to "AR Emoji" and stickers.
* **Unused Features:** Phone-related apps, Samsung Pass, Kids Mode, etc. (basically, stuff I don't personally use).

## Prerequisites

1. You must have [ADB](https://developer.android.com/studio/command-line/adb) installed and working on your computer.
2. **USB Debugging** must be enabled on your tablet (You can find it under Settings > Developer Options).

## How to Use

These instructions are for a **Linux environment**, where the script was written and tested.

1.  Connect your tablet to your computer via USB.
2.  A prompt will appear on your tablet's screen. Allow the USB debugging connection.
3.  Download the `your-script-name.sh` file.
4.  Open a terminal in the folder where you saved the script.
5.  First, make the script executable with this command:
    ```bash
    chmod +x your-script-name.sh
    ```
6.  Now, run it:
    ```bash
    ./your-script-name.sh
    ```

**Note for Windows users:** I don't use Windows, so I cannot confirm if this works or provide support for it. You might be able to run it using **Git Bash**, which creates a Linux-like environment on Windows, but this is untested.

The script will then check for a connection and begin the cleanup. A reboot is recommended when it's finished.

## Operation Modes

The script has two modes. You can switch between them by editing the file.

* **Uninstall (Default):** Uninstalls the apps for the current user. This is the cleanest method and is reversible.
* **Disable:** Simply disables the apps. This is safer and even easier to revert.

To switch modes, open the `.sh` file in a text editor. Comment out the active `run_command` function (by adding a `#` at the beginning of each line) and uncomment the other one (by removing the `#` symbols).

## How to Revert the Changes

If you change your mind or if something stops working, you can easily revert the changes using these ADB commands:

* **If you used the `disable` mode:**
  ```bash
  adb shell pm enable package.name.here
  ```
* **If you used the `uninstall` mode:**
  ```bash
  adb shell cmd package install-existing package.name.here
  ```