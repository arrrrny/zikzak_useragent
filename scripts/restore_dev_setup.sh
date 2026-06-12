#!/bin/bash
# ZikZak UserAgent - Restore Dev Mode
# ------------------------------------
# Converts all package dependencies to path dependencies
# for local development across all packages.

echo "🔥 ZikZak UserAgent - Restoring Development Mode 🔥"
echo "Converting all dependencies to path dependencies..."

# Root directory of the project
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "Root directory: $ROOT_DIR"

# Packages in this project
PACKAGES=(
    "zikzak_useragent"
    "zikzak_useragent_android"
    "zikzak_useragent_ios"
    "zikzak_useragent_macos"
    "zikzak_useragent_platform_interface"
)

# Function to update pubspec.yaml for development mode
update_for_dev_mode() {
    local package_dir=$1
    local pubspec_file="$package_dir/pubspec.yaml"
    local path_prefix="../"

    if [[ "$package_dir" == *"/example" ]]; then
        path_prefix="../../"
    fi

    if [ ! -f "$pubspec_file" ]; then
        echo "⚠️ Pubspec file not found at $pubspec_file"
        return
    fi

    echo "Processing $pubspec_file (depth prefix: $path_prefix)"

    # Uncomment any commented path dependencies
    sed -i.bak -E "s|^    #([ ]+path: $path_prefix"zikzak_useragent".*)[ ]#[ ]Commented for publishing|\1|g" "$pubspec_file"

    # Convert versioned dependencies to path dependencies
    awk -v prefix="$path_prefix" '
    BEGIN {
        in_dev_dependencies = 0;
        packages["zikzak_useragent_platform_interface"] = 1;
        packages["zikzak_useragent_android"] = 1;
        packages["zikzak_useragent_ios"] = 1;
        packages["zikzak_useragent_macos"] = 1;
    }

    # Track when we enter dev_dependencies section
    /^dev_dependencies:/ {
        in_dev_dependencies = 1;
        print;
        next;
    }

    # Convert versioned dependencies to path in dev_dependencies
    in_dev_dependencies && /^  zikzak_useragent/ {
        pkg_name = $1;
        sub(/:$/, "", pkg_name);

        if (packages[pkg_name]) {
            if ($0 !~ /path:/) {
                print "  " pkg_name ":";
                print "    path: " prefix pkg_name;
                getline;
                next;
            }
        }
    }

    # Reset flag when leaving dev_dependencies section
    in_dev_dependencies && /^[a-zA-Z]/ && !/^  / {
        in_dev_dependencies = 0;
    }

    # Print all other lines unchanged
    { print }
    ' "$pubspec_file" > "${pubspec_file}.new"

    if [ -s "${pubspec_file}.new" ]; then
        mv "${pubspec_file}.new" "$pubspec_file"
    else
        echo "⚠️ Warning: awk processing failed for $pubspec_file"
    fi

    # Replace versioned dependencies with path dependencies in main dependencies
    sed -i.bak -E "s|zikzak_useragent_platform_interface: \\^[0-9]+\\.[0-9]+\\.[0-9]+|zikzak_useragent_platform_interface:\\n    path: ${path_prefix}zikzak_useragent_platform_interface|g" "$pubspec_file"
    sed -i.bak -E "s|zikzak_useragent_android: \\^[0-9]+\\.[0-9]+\\.[0-9]+|zikzak_useragent_android:\\n    path: ${path_prefix}zikzak_useragent_android|g" "$pubspec_file"
    sed -i.bak -E "s|zikzak_useragent_ios: \\^[0-9]+\\.[0-9]+\\.[0-9]+|zikzak_useragent_ios:\\n    path: ${path_prefix}zikzak_useragent_ios|g" "$pubspec_file"
    sed -i.bak -E "s|zikzak_useragent_macos: \\^[0-9]+\\.[0-9]+\\.[0-9]+|zikzak_useragent_macos:\\n    path: ${path_prefix}zikzak_useragent_macos|g" "$pubspec_file"

    # Clean up backup files
    rm -f "${pubspec_file}.bak"

    echo "✅ Updated $pubspec_file to use path dependencies"
}

# Process each package
for package in "${PACKAGES[@]}"; do
    if [ -d "$ROOT_DIR/$package" ]; then
        update_for_dev_mode "$ROOT_DIR/$package"
        if [ -d "$ROOT_DIR/$package/example" ]; then
            update_for_dev_mode "$ROOT_DIR/$package/example"
        fi
    else
        echo "⚠️ Directory not found: $ROOT_DIR/$package"
    fi
done

# Run flutter pub get on all packages
echo "Running 'flutter pub get' on all packages..."
for package in "${PACKAGES[@]}"; do
    if [ -d "$ROOT_DIR/$package" ]; then
        echo "Getting dependencies for $package..."
        (cd "$ROOT_DIR/$package" && flutter pub get)
    fi
done

echo ""
echo "🔥🔥🔥 DEVELOPMENT MODE SETUP COMPLETE! 🔥🔥🔥"
echo "All packages now use path dependencies for local development."
