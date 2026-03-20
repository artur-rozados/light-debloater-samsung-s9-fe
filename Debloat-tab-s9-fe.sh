#!/bin/bash

# --- Light & Interactive Debloat Script for Samsung Galaxy Devices ---
# Compatible with One UI 6+ (Phones and Tablets)
# Focus: Removing telemetry, bloatware, and offering choices for user-dismissed features.

# --- OPERATION MODE ---
# By default, "Delete" mode is active.
# To switch to Safe Mode (Disable), comment the current function and uncomment the top one.

#====================================================================================
# SAFE MODE: Simply disables the app. Reversible with 'adb shell pm enable'.
#run_command() {
#    echo "  -> Disabling $1..."
#    adb shell pm disable-user --user 0 "$1"
#}

# DELETE MODE: Uninstalls for the current user. Reversible with 'install-existing'.
run_command() {
    echo "  -> Uninstalling $1..."
    adb shell pm uninstall -k --user 0 "$1" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "     Success"
    else
        echo "     Failed or Not Installed"
    fi
}
#====================================================================================

# Helper function for interactive prompts
prompt_category() {
    echo ""
    read -p "❓ $1 [y/N]: " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        for pkg in "${@:2}"; do
            run_command "$pkg"
        done
    else
        echo "  -> Skipping..."
    fi
}

# --- INITIAL CHECK ---
echo "Checking for device connection..."
adb wait-for-device
echo "Device connected. Starting automated cleanup..."
sleep 2

# --- [STEP 1: Core Telemetry, Data Collectors & Meta] ---
echo ""
echo "=== [STEP 1: Removing Core Telemetry & Facebook Bloat] ==="
run_command com.samsung.android.rubin.app
run_command com.samsung.android.knox.analytics.uploader
run_command com.samsung.android.da.daagent
run_command com.samsung.android.bbc.bbcagent
run_command com.google.android.feedback
run_command com.google.android.gms.location.history
# Meta / Facebook Background Services
run_command com.facebook.system
run_command com.facebook.appmanager
run_command com.facebook.services


# --- [STEP 2: Safe Bloatware & Unused Features] ---
echo ""
echo "=== [STEP 2: Removing Safe Bloatware & Samsung Junk] ==="
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
run_command com.samsung.android.app.spage # Bixby Home / Samsung Daily
run_command com.sec.android.app.billing # Samsung Checkout
run_command com.samsung.android.voc # Samsung Members
run_command com.samsung.android.mdx # Link to Windows
run_command com.samsung.android.mdx.kit


# --- [STEP 3: Background Processes and Initializers] ---
echo ""
echo "=== [STEP 3: Removing Background Initializers] ==="
run_command com.android.hotwordenrollment.okgoogle
run_command com.android.hotwordenrollment.xgoogle
run_command com.google.android.onetimeinitializer
run_command com.samsung.android.app.sharelive
run_command com.samsung.android.bixby.agent
run_command com.samsung.android.bixby.wakeup
run_command com.samsung.android.visionintelligence
run_command com.skms.android.agent
run_command com.microsoft.appmanager
run_command com.microsoft.skydrive
run_command com.samsung.android.scloud


# ========================================================================
# --- [EXTRA DEBLOAT: INTERACTIVE SECTION] ---
# ========================================================================
echo ""
echo "========================================================="
echo "        EXTRA DEBLOAT - USER CONFIRMATION REQUIRED       "
echo "========================================================="

prompt_category "Remove Telephony Functions? (ONLY YES IF YOU ARE ON A WI-FI TABLET. Will break phone calls on phones!)" \
    com.android.calllogbackup com.hiya.star com.samsung.android.smartcallprovider

prompt_category "Remove Default Browsers (Google Chrome & Samsung Internet)? (WARNING: Have another browser installed first!)" \
    com.android.chrome com.sec.android.app.sbrowser

prompt_category "Remove Samsung Keyboard (Honeyboard)? (WARNING: Have another keyboard installed first, or you will be locked out!)" \
    com.samsung.android.honeyboard com.sec.android.inputmethod

prompt_category "Remove Google Photos? (Prevents background cloud scanning/uploading)" \
    com.google.android.apps.photos

prompt_category "Remove Official YouTube? (Useful if you plan to install ReVanced)" \
    com.google.android.youtube

prompt_category "Remove Samsung Wallet & Samsung Pay?" \
    com.samsung.android.spay com.samsung.android.spaymini

prompt_category "Remove Gaming Hub? (Keeps Game Optimizing Service and Game Booster intact for performance control)" \
    com.samsung.android.game.gamehome

prompt_category "Remove Samsung Health & SmartThings?" \
    com.sec.android.app.shealth com.samsung.android.oneconnect

prompt_category "Remove Samsung Shop & Global Goals?" \
    com.samsung.ecomm com.samsung.sree

prompt_category "Remove Digital Wellbeing (Google & Samsung)? (Stops screen time tracking background services)" \
    com.samsung.android.wellbeing com.google.android.apps.wellbeing

prompt_category "Remove UI Extras (Tips, Themes, and Routines)?" \
    com.samsung.android.app.tips com.samsung.android.themestore com.samsung.android.app.routines

echo ""
echo "-------------------------------------"
echo "Cleanup complete!"
echo "It is highly recommended to reboot the device to ensure all changes are applied and background ghosts are killed."
echo "To reboot via ADB, type: adb reboot"
