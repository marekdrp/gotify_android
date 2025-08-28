#!/bin/bash

yes | sdkmanager --licenses --sdk_root=$ANDROID_SDK_ROOT

./gradlew clean assembleRelease --stacktrace

cp app/build/outputs/apk/release/app-release.apk gotify-release.apk
