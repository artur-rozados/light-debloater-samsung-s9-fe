#!/bin/bash

# --- Light Debloat Script for the Galaxy Tab S9 FE (SM-X510) ---
# Focus: Removing telemetry, bloatware, and user-dismissed features without breaking default functionalities


# --- OPERATION MODE ---
# There are two modes. By default, the "Delete" mode is active.
# -> To switch modes, comment out the current mode and uncomment the preferred one.

#====================================================================================
# SAFE MODE (Default): Simply disables the app. Reversible with the 'enable' command.
#run_command() {
#    echo "  -> Disabling $1..."
#    adb shell pm disable-user --user 0 "$1"
#}


# Delete mode: Uninstalls for the current user. Reversible with 'install-existing'.
 run_command() {
    echo "  -> Uninstalling $1..."
    adb shell pm uninstall -k --user 0 "$1"
}
#====================================================================================

# --- INITIAL CHECK ---
echo "Checking for device connection..."
adb wait-for-device

echo "Device connected. Starting cleanup..."
sleep 3


# --- [STEP 1: Telemetry and Data Collectors] ---
echo "[Removing Telemetry and Data Collectors...]"
run_command com.samsung.android.rubin.app
run_command com.samsung.android.knox.analytics.uploader
run_command com.samsung.android.da.daagent
run_command com.samsung.android.bbc.bbcagent
run_command com.google.android.feedback
run_command com.google.android.gms.location.history


# --- [STEP 2: Bloatware and AR Junk] ---
echo "[Removing Bloatware and AR junk...]"
run_command android.autoinstalls.config.samsung
run_command com.android.egg
run_command com.android.providers.partnerbookmarks
run_command com.samsung.android.app.camera.sticker.facearavatar.preload
run_command com.samsung.android.aremoji
run_command com.samsung.android.aremojieditor
run_command com.samsung.android.stickercenter
run_command com.sec.android.mimage.avatarstickers
run_command com.samsung.android.forest
run_command com.samsung.safetyinformation
run_command com.samsung.android.kidsinstaller
run_command com.samsung.android.app.watchmanagerstub


# --- [STEP 3: Phone-related Functions (Useless on a Tablet without SIM card)] ---
echo "[Removing telephony functions...]"
run_command com.android.calllogbackup
run_command com.hiya.star
run_command com.samsung.android.smartcallprovider


# --- [STEP 4: Partner Apps and Duplicates] ---
echo "[Removing partner apps...]"
run_command com.microsoft.appmanager
run_command com.microsoft.skydrive


# --- [STEP 5: User-Selected Samsung Features] ---
echo "[Removing user-selected Samsung features...]"
run_command com.samsung.android.game.gametools
run_command com.samsung.android.game.gos
run_command com.samsung.android.samsungpass
run_command com.samsung.android.samsungpassautofill
run_command com.samsung.android.scloud


# --- [STEP 6: Background Processes and Initializers] ---
echo "[Removing background processes and initializers...]"
run_command com.android.hotwordenrollment.okgoogle
run_command com.android.hotwordenrollment.xgoogle
run_command com.google.android.onetimeinitializer
run_command com.samsung.android.app.sharelive
run_command com.samsung.android.bixby.agent
run_command com.samsung.android.bixby.wakeup
run_command com.samsung.android.bixbyvision.framework
run_command com.samsung.android.visionintelligence
run_command com.sec.android.easyMover
run_command com.sec.android.easyMover.Agent
run_command com.skms.android.agent
run_command com.samsung.android.smartswitchassistant


echo "-------------------------------------"
echo "Cleanup complete!"
echo "It is recommended to reboot the tablet to ensure all changes are applied."
echo "To reboot via ADB, use the command: adb reboot"