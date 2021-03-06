#!/bin/bash
set -e

APK_OUT=${1:-ai.comma.plus.offroad.apk}
TOOLS="$PWD/../tools"

export SENTRY_WIZARD_INTEGRATION=reactNative

yarn
node_modules/.bin/react-native link

mkdir -p android/app/src/main/assets
rm android/app/src/main/assets/index.android.bundl* || true
rm -r android/build android/app/build || true

if [ -z "$DEBUG" ]; then
    node_modules/.bin/react-native bundle --platform android --dev false --entry-file index.js \
          --bundle-output android/app/src/main/assets/index.android.bundle \
          --assets-dest android/app/src/main/res/
fi

echo "android/app/src/main/res/drawable-mdpi
android/app/src/main/res/drawable-hdpi
android/app/src/main/res/drawable-xhdpi
android/app/src/main/res/drawable-xxhdpi
android/app/src/main/res/drawable-xxxhdpi"| xargs rm -r || true

if [ -z "$DEBUG" ]; then
    APK_PATH=android/app/build/outputs/apk/release/app-release-unsigned.apk
    (cd android && ./gradlew clean && (./gradlew assembleRelease || ./gradlew assembleRelease))
else
    APK_PATH=android/app/build/outputs/apk/debug/app-debug.apk
    (cd android && ./gradlew clean && (./gradlew assembleDebug || ./gradlew assembleDebug))
fi

java -jar $TOOLS/signapk/signapk.jar $TOOLS/signapk/certificate.pem $TOOLS/signapk/key.pk8 $APK_PATH $APK_OUT
echo "build complete"
