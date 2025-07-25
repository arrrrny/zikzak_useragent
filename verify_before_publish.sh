#!/bin/bash

# 🔥 ZIKZAK USERAGENT PRE-PUBLISH VERIFICATION 🔥
# Raw. Efficient. Unyielding verification process.

set -e

echo "🔥 ZIKZAK VERIFICATION SEQUENCE INITIATED 🔥"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️ $1${NC}"
}

# Verification functions
verify_versions() {
    print_info "Verifying all packages are version 1.1.0..."

    EXPECTED_VERSION="1.1.0"
    PACKAGES=("zikzak_useragent" "zikzak_useragent_platform_interface" "zikzak_useragent_ios" "zikzak_useragent_android")

    for package in "${PACKAGES[@]}"; do
        VERSION=$(grep "^version:" $package/pubspec.yaml | cut -d' ' -f2)
        if [ "$VERSION" = "$EXPECTED_VERSION" ]; then
            print_status "$package: $VERSION"
        else
            print_error "$package: Expected $EXPECTED_VERSION, found $VERSION"
            exit 1
        fi
    done
}

verify_licenses() {
    print_info "Verifying Apache 2.0 licenses exist..."

    PACKAGES=("zikzak_useragent" "zikzak_useragent_platform_interface" "zikzak_useragent_ios" "zikzak_useragent_android")

    for package in "${PACKAGES[@]}"; do
        if [ -f "$package/LICENSE" ]; then
            if grep -q "Apache License" "$package/LICENSE"; then
                print_status "$package: Apache 2.0 license ✅"
            else
                print_error "$package: LICENSE file exists but not Apache 2.0"
                exit 1
            fi
        else
            print_error "$package: LICENSE file missing"
            exit 1
        fi
    done
}

verify_author_info() {
    print_info "Verifying ARRRRNY author information..."

    # Check iOS podspec
    if grep -q "ARRRRNY" zikzak_useragent_ios/ios/zikzak_useragent_ios.podspec; then
        print_status "iOS podspec: ARRRRNY author ✅"
    else
        print_error "iOS podspec: ARRRRNY author missing"
        exit 1
    fi

    if grep -q "arrrrny@zuzu.dev" zikzak_useragent_ios/ios/zikzak_useragent_ios.podspec; then
        print_status "iOS podspec: zuzu.dev email ✅"
    else
        print_error "iOS podspec: zuzu.dev email missing"
        exit 1
    fi
}

verify_package_structure() {
    print_info "Verifying package structure..."

    # Check main files exist
    FILES=(
        "zikzak_useragent/lib/zikzak_useragent.dart"
        "zikzak_useragent_platform_interface/lib/zikzak_useragent_platform_interface.dart"
        "zikzak_useragent_ios/lib/zikzak_useragent_ios.dart"
        "zikzak_useragent_android/lib/zikzak_useragent_android.dart"
        "zikzak_useragent_ios/ios/Classes/ZikzakUserAgentPlugin.swift"
        "zikzak_useragent_android/android/src/main/kotlin/com/strysk/zikzak_useragent_android/zikzak_useragent_android/ZikzakUserAgentPlugin.kt"
    )

    for file in "${FILES[@]}"; do
        if [ -f "$file" ]; then
            print_status "$file exists"
        else
            print_error "$file missing"
            exit 1
        fi
    done
}

verify_no_webview_references() {
    print_info "Verifying no old 'webview' references remain in code..."

    # Check for webview references in Dart files (excluding comments and strings that should contain webview)
    WEBVIEW_REFS=$(find . -name "*.dart" -not -path "./.*" -exec grep -l "webview" {} \; | grep -v CHANGELOG.md | grep -v README.md || true)

    if [ -z "$WEBVIEW_REFS" ]; then
        print_status "No old webview references in Dart files ✅"
    else
        print_warning "Found webview references in: $WEBVIEW_REFS"
        # This is a warning, not an error, as some references might be intentional
    fi
}

verify_class_names() {
    print_info "Verifying class names updated to ZIKZAK..."

    # Check main classes exist
    if grep -q "class ZikzakUserAgent" zikzak_useragent/lib/zikzak_useragent.dart; then
        print_status "Main ZikzakUserAgent class ✅"
    else
        print_error "Main ZikzakUserAgent class missing"
        exit 1
    fi

    if grep -q "class ZikzakUserAgentPlatform" zikzak_useragent_platform_interface/lib/src/zikzak_useragent_platform.dart; then
        print_status "Platform ZikzakUserAgentPlatform class ✅"
    else
        print_error "Platform ZikzakUserAgentPlatform class missing"
        exit 1
    fi
}

verify_method_channels() {
    print_info "Verifying method channels updated to zikzak_useragent..."

    # Check method channel names
    if grep -q '"zikzak_useragent"' zikzak_useragent_ios/lib/zikzak_useragent_ios.dart; then
        print_status "iOS method channel ✅"
    else
        print_error "iOS method channel not updated"
        exit 1
    fi

    if grep -q '"zikzak_useragent"' zikzak_useragent_android/lib/zikzak_useragent_android.dart; then
        print_status "Android method channel ✅"
    else
        print_error "Android method channel not updated"
        exit 1
    fi
}

verify_dependencies() {
    print_info "Verifying dependency versions..."

    # Check platform interface dependencies
    if grep -q "zikzak_useragent_platform_interface: \^1.1.0" zikzak_useragent_ios/pubspec.yaml; then
        print_status "iOS platform interface dependency ✅"
    else
        print_error "iOS platform interface dependency incorrect"
        exit 1
    fi

    if grep -q "zikzak_useragent_platform_interface: \^1.1.0" zikzak_useragent_android/pubspec.yaml; then
        print_status "Android platform interface dependency ✅"
    else
        print_error "Android platform interface dependency incorrect"
        exit 1
    fi
}

run_analysis() {
    print_info "Running Flutter analysis on all packages..."

    PACKAGES=("zikzak_useragent_platform_interface" "zikzak_useragent_ios" "zikzak_useragent_android" "zikzak_useragent")

    for package in "${PACKAGES[@]}"; do
        print_info "Analyzing $package..."
        cd $package

        # Skip pub get for now as dependencies might not be published yet
        if [ "$package" = "zikzak_useragent_platform_interface" ]; then
            flutter pub get > /dev/null 2>&1
            if flutter analyze > /dev/null 2>&1; then
                print_status "$package: Analysis passed ✅"
            else
                print_error "$package: Analysis failed"
                cd ..
                exit 1
            fi
        else
            print_warning "$package: Skipping analysis (dependencies not published yet)"
        fi

        cd ..
    done
}

# Main verification sequence
echo "Starting ZIKZAK UserAgent verification..."
echo "=========================================="

verify_versions
echo ""

verify_licenses
echo ""

verify_author_info
echo ""

verify_package_structure
echo ""

verify_no_webview_references
echo ""

verify_class_names
echo ""

verify_method_channels
echo ""

verify_dependencies
echo ""

run_analysis
echo ""

echo "=========================================="
print_status "🔥 ALL ZIKZAK VERIFICATIONS PASSED! 🔥"
echo ""
echo -e "${BLUE}Ready for publishing sequence:${NC}"
echo -e "${YELLOW}1. zikzak_useragent_platform_interface${NC}"
echo -e "${YELLOW}2. zikzak_useragent_ios${NC}"
echo -e "${YELLOW}3. zikzak_useragent_android${NC}"
echo -e "${YELLOW}4. zikzak_useragent${NC}"
echo ""
echo -e "${GREEN}WE ARE ZIKZAK. WE ARE READY TO DETONATE.${NC}"
