#!/bin/bash

# Function to copy framework to iOS and macOS directories
# Parameters:
#   $1: The name of the framework to be copied
#   $2: The target platform (ios or macos)
#
# Usage: copy_framework <framework_name> <target_platform>
# Example: copy_framework MyFramework ios
copy_framework() {
        # Create the target directory if it doesn't exist
        if [ ! -d "../packages/flutter_peer2peer/$2/Frameworks" ]; then
                mkdir -p "../packages/flutter_peer2peer/$2/Frameworks"
        fi

        # Copy the framework to the target directory
        cp "$1" "../packages/flutter_peer2peer/$2/Frameworks"
}

# Setup
BUILD_DIR=platform-build
mkdir $BUILD_DIR
cd $BUILD_DIR

# Build static libs
for TARGET in \
        aarch64-apple-ios x86_64-apple-ios aarch64-apple-ios-sim \
        x86_64-apple-darwin aarch64-apple-darwin
do
        rustup target add $TARGET
        cargo build -r --target=$TARGET
done

# Create XCFramework zip
FRAMEWORK="Peer2Peer.xcframework"
LIBNAME=libpeer2peer.a
mkdir mac-lipo ios-sim-lipo
IOS_SIM_LIPO=ios-sim-lipo/$LIBNAME
MAC_LIPO=mac-lipo/$LIBNAME
lipo -create -output $IOS_SIM_LIPO \
        ../target/aarch64-apple-ios-sim/release/$LIBNAME \
        ../target/x86_64-apple-ios/release/$LIBNAME

lipo -create -output $MAC_LIPO \
        ../target/aarch64-apple-darwin/release/$LIBNAME \
        ../target/x86_64-apple-darwin/release/$LIBNAME

xcodebuild -create-xcframework \
        -library $IOS_SIM_LIPO \
        -library $MAC_LIPO \
        -library ../target/aarch64-apple-ios/release/$LIBNAME \
        -output $FRAMEWORK
zip -r $FRAMEWORK.zip $FRAMEWORK

copy_framework $FRAMEWORK.zip ios
copy_framework $FRAMEWORK.zip macos

# Cleanup
rm -rf ios-sim-lipo mac-lipo $FRAMEWORK
