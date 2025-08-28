{ pkgs ? import <nixpkgs> {} }:

let
  android-nixpkgs = import (builtins.fetchGit {
    url = "https://github.com/tadfisher/android-nixpkgs.git";
  }) { };

  sdk = android-nixpkgs.sdk (sdkPkgs: with sdkPkgs; [
    cmdline-tools-latest
    build-tools-35-0-0      # Match your project's build-tools version
    platforms-android-36    # Match your project's target platform
    platform-tools
  ]);
in

pkgs.mkShell {
  buildInputs = [
    pkgs.jdk17
    pkgs.gradle
    sdk
  ];

  shellHook = ''
    unset ANDROID_HOME
    export ANDROID_SDK_ROOT=$PWD/.android/sdk
    mkdir -p $ANDROID_SDK_ROOT

    export PATH=$sdk/cmdline-tools/latest/bin:$PATH
    export PATH=$sdk/build-tools/35.0.0:$PATH
    export PATH=$sdk/platform-tools:$PATH

    echo "Android build environment ready (Java 17, Gradle, minimal SDK)."
  '';
}
