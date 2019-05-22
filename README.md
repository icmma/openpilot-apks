# openpilot-apks

The source code for the APKs that run inside openpilot.

## offroad

offroad is the interactive UI displayed while your car is off. Its main features are device setup, comma account pairing, and settings management.

## frame

frame contains the sidebar and manages the background color behind openpilot UI.

## black

black draws a box behind the openpilot `ui.c` while driving.

## setup

NEOS setup compatible with the `openpilot.comma.ai` installation configuration server. Based on CyanogenOS setup.

## Shared Dependencies

Ubuntu 16.04:

```
Android SDK:
sudo apt install openjdk-8-jdk openjdk-8-jre android-sdk
sudo chown -R $(whoami): /usr/lib/android-sdk
echo 'export ANDROID_HOME=/usr/lib/android-sdk' >> ~/.bashrc
echo 'export PATH="$PATH:/usr/lib/android-sdk/tools/bin"' >> ~/.bashrc
source ~/.bashrc

Android SDK Tools:
curl -o sdk-tools.zip "https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
unzip -o sdk-tools.zip -d "/usr/lib/android-sdk/"
chmod +x /usr/lib/android-sdk/tools/bin/*
sdkmanager "platform-tools" "platforms;android-23" "platforms;android-27"
```

### Offroad Dependencies
```
Node:
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs

Yarn:
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
```

## Build

See build.sh in project directories.
