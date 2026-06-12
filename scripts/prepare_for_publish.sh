#!/bin/bash
set -e

# Color codes for better readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if version argument is provided
if [ "$#" -eq 0 ]; then
    echo -e "${YELLOW}No version argument provided. Attempting to detect version from zikzak_useragent/pubspec.yaml...${NC}"
    PROJECT_DIR_FIXED="$( cd "$(dirname "$0")/.." >/dev/null 2>&1 ; pwd -P )"
    DETECTED_VERSION=$(grep "^version:" "$PROJECT_DIR_FIXED/zikzak_useragent/pubspec.yaml" | sed 's/version: //' | tr -d '[:space:]')

    if [ -n "$DETECTED_VERSION" ]; then
        echo -e "${GREEN}Detected version: $DETECTED_VERSION${NC}"
        VERSION=$DETECTED_VERSION
    else
        echo -e "${RED}Error: Could not detect version from pubspec.yaml.${NC}"
        echo -e "Usage: $0 <version_number>"
        exit 1
    fi
else
    VERSION=$1
fi
BRANCH_NAME="publish-$VERSION"
ROOT_DIR="$(pwd)"

# Validate semantic version format (simple check)
if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo -e "${RED}Error: Version should follow semantic versioning (e.g., 1.2.5)${NC}"
    exit 1
fi

echo -e "${BLUE}=== Preparing to publish version $VERSION ===${NC}"

# Create a new branch for publishing
git checkout -b $BRANCH_NAME
echo -e "${GREEN}Created branch: $BRANCH_NAME${NC}"

# List of all packages to update
PACKAGES=(
    "zikzak_useragent_platform_interface"
    "zikzak_useragent_android"
    "zikzak_useragent_ios"
    "zikzak_useragent_macos"
    "zikzak_useragent"
)

# Update versions in all package pubspec.yaml files
for pkg in "${PACKAGES[@]}"; do
    echo -e "${BLUE}Updating version in $pkg to $VERSION${NC}"
    if [ ! -d "$ROOT_DIR/$pkg" ]; then
        echo -e "${RED}Warning: Package directory '$pkg' not found. Skipping.${NC}"
        continue
    fi

    if [ -f "$ROOT_DIR/$pkg/pubspec.yaml" ]; then
        # Update version in pubspec.yaml
        sed -i '' "s/^version:.*/version: $VERSION/" "$ROOT_DIR/$pkg/pubspec.yaml"

        # Verify the update
        new_version=$(grep "^version:" "$ROOT_DIR/$pkg/pubspec.yaml" | sed 's/version: //' | tr -d '[:space:]')
        if [ "$new_version" != "$VERSION" ]; then
            echo -e "${RED}Failed to update version for $pkg to $VERSION. Current version: $new_version${NC}"
        else
            echo -e "${GREEN}Successfully updated $pkg to version $VERSION${NC}"
        fi
    else
        echo -e "${RED}Warning: pubspec.yaml not found in $pkg. Skipping.${NC}"
    fi
done

# Function to convert path dependencies to versioned dependencies
convert_path_to_versioned() {
    local file="$1"
    local version="$2"
    local exclude_pkg="$3"

    echo -e "${YELLOW}Converting path dependencies and updating versioned dependencies to $version in $file${NC}"

    # List of zikzak packages to convert/update
    local packages=(
        "zikzak_useragent_platform_interface"
        "zikzak_useragent_android"
        "zikzak_useragent_ios"
        "zikzak_useragent_macos"
        "zikzak_useragent"
    )

    # Create a temporary file
    local temp_file="${file}.tmp"
    cp "$file" "$temp_file"

    for dep_pkg in "${packages[@]}"; do
        # Skip excluded package (useful for examples that must keep path dependency on their parent)
        if [ "$dep_pkg" == "$exclude_pkg" ]; then
            continue
        fi

        # Replace single-line versioned dependencies (package: ^1.2.3)
        sed -i '' "s/^[[:space:]]*${dep_pkg}:[[:space:]]*\^[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*[[:space:]]*$/  ${dep_pkg}: ^${version}/" "$temp_file"

        # Replace single-line versioned dependencies (package: 1.2.3)
        sed -i '' "s/^[[:space:]]*${dep_pkg}:[[:space:]]*[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*[[:space:]]*$/  ${dep_pkg}: ^${version}/" "$temp_file"

        # Handle multi-line path dependencies
        sed -i '' "/^[[:space:]]*${dep_pkg}:[[:space:]]*$/,/^[[:space:]]*[^[:space:]]/ {
            s/^\([[:space:]]*${dep_pkg}\):[[:space:]]*$/\1: ^${version}/
            /^[[:space:]]*path:[[:space:]]*/ d
            /^[[:space:]]*version:[[:space:]]*/ d
        }" "$temp_file"

        # Handle malformed dependencies where version and path are on separate lines
        awk -v dep_pkg="$dep_pkg" -v version="$version" '
        BEGIN { in_malformed = 0 }
        {
            if ($0 ~ "^[[:space:]]*" dep_pkg ":[[:space:]]*\\^[0-9]+\\.[0-9]+\\.[0-9]+[[:space:]]*$") {
                print "  " dep_pkg ": ^" version
                in_malformed = 1
                next
            }
            if (in_malformed && $0 ~ /^[[:space:]]*path:/) {
                in_malformed = 0
                next
            }
            in_malformed = 0
            print $0
        }' "$temp_file" > "${temp_file}.fixed"
        mv "${temp_file}.fixed" "$temp_file"
    done

    # Remove the entire dependency_overrides section (dev-only, must not be in published packages)
    awk '
    BEGIN { skip = 0 }
    /^dependency_overrides:/ { skip = 1; next }
    skip && /^[^[:space:]]/ { skip = 0 }
    !skip { print }
    ' "$temp_file" > "${temp_file}.fixed"
    mv "${temp_file}.fixed" "$temp_file"

    mv "$temp_file" "$file"

    echo -e "${GREEN}Updated zikzak dependencies to version ^$version in $file${NC}"
}

# Update dependencies in each package to use versioned dependencies instead of path
echo -e "${BLUE}Updating dependencies to use versioned references${NC}"

for pkg in "${PACKAGES[@]}"; do
    if [ -f "$ROOT_DIR/$pkg/pubspec.yaml" ]; then
        convert_path_to_versioned "$ROOT_DIR/$pkg/pubspec.yaml" "$VERSION"
    else
        echo -e "${RED}Warning: pubspec.yaml not found in $pkg. Skipping.${NC}"
    fi

    # Also update dependencies in example app if it exists
    if [ -f "$ROOT_DIR/$pkg/example/pubspec.yaml" ]; then
        echo -e "${BLUE}Updating dependencies in $pkg example${NC}"
        convert_path_to_versioned "$ROOT_DIR/$pkg/example/pubspec.yaml" "$VERSION" "$pkg"
    fi
done

# Generate changelog content
ROOT_CHANGELOG="$ROOT_DIR/zikzak_useragent/CHANGELOG.md"
EXISTING_ENTRY=""

if [ -f "$ROOT_CHANGELOG" ]; then
    EXISTING_ENTRY=$(awk "/^## $VERSION - /{found=1; next} /^## [0-9]+\\.[0-9]+\\.[0-9]+/{if(found) exit} found" "$ROOT_CHANGELOG" 2>/dev/null || true)
fi

if [ -n "$EXISTING_ENTRY" ]; then
    echo -e "${GREEN}Found existing changelog entry for version $VERSION in root CHANGELOG.md, using it...${NC}"
    CHANGELOG_CONTENT="$EXISTING_ENTRY"
else
    echo -e "${BLUE}No existing changelog entry found. Generating from git history...${NC}"
    CHANGELOG_CONTENT=""
    LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "")

    if [ -z "$LAST_TAG" ]; then
        echo -e "${YELLOW}No tags found. Analyzing all commits...${NC}"
        LOGS=$(git log --pretty=format:"%s")
    else
        echo -e "${YELLOW}Analyzing commits since $LAST_TAG...${NC}"
        LOGS=$(git log --pretty=format:"%s" "$LAST_TAG..HEAD")
    fi

    FEATURES=$(echo "$LOGS" | grep -i "^Feature:" | sed 's/^/* /' || true)
    CHANGES=$(echo "$LOGS" | grep -i "^Changed:\|^Change:" | sed 's/^/* /' || true)
    FIXES=$(echo "$LOGS" | grep -i "^Fixed:\|^Fix:" | sed 's/^/* /' || true)

    if [ ! -z "$FEATURES" ]; then
        CHANGELOG_CONTENT="${CHANGELOG_CONTENT}${FEATURES}\n"
    fi
    if [ ! -z "$CHANGES" ]; then
        CHANGELOG_CONTENT="${CHANGELOG_CONTENT}${CHANGES}\n"
    fi
    if [ ! -z "$FIXES" ]; then
        CHANGELOG_CONTENT="${CHANGELOG_CONTENT}${FIXES}\n"
    fi

    if [ -z "$CHANGELOG_CONTENT" ]; then
        CHANGELOG_CONTENT=$(echo "$LOGS" | sed 's/^/* /')
    fi
    if [ -z "$CHANGELOG_CONTENT" ]; then
        CHANGELOG_CONTENT="* Prepare for publishing version $VERSION"
    fi
fi

echo -e "${YELLOW}Generated Changelog Content:${NC}"
echo -e "$CHANGELOG_CONTENT"

# Ask for the commit message
echo -e "${YELLOW}Enter a commit message title for version $VERSION (default: 'Prepare for publishing version $VERSION'):${NC}"
read -r COMMIT_MESSAGE
if [ -z "$COMMIT_MESSAGE" ]; then
    COMMIT_MESSAGE="Prepare for publishing version $VERSION"
fi

# Update CHANGELOG.md files with new version
CURRENT_DATE=$(date +"%Y-%m-%d")
for pkg in "${PACKAGES[@]}"; do
    if [ -f "$ROOT_DIR/$pkg/CHANGELOG.md" ]; then
        if [ "$pkg" == "zikzak_useragent" ] && [ -n "$EXISTING_ENTRY" ]; then
            echo -e "${GREEN}Root CHANGELOG.md already has entry for $VERSION, skipping...${NC}"
            continue
        fi
        echo -e "${BLUE}Updating CHANGELOG.md in $pkg${NC}"
        TEMP_CHANGELOG="$ROOT_DIR/$pkg/CHANGELOG.md.tmp"
        echo -e "## $VERSION - $CURRENT_DATE\n" > "$TEMP_CHANGELOG"
        echo -e "$CHANGELOG_CONTENT" >> "$TEMP_CHANGELOG"
        cat "$ROOT_DIR/$pkg/CHANGELOG.md" >> "$TEMP_CHANGELOG"
        mv "$TEMP_CHANGELOG" "$ROOT_DIR/$pkg/CHANGELOG.md"
    else
        echo -e "${RED}Warning: CHANGELOG.md not found in $pkg. Creating new CHANGELOG.md${NC}"
        echo -e "## $VERSION - $CURRENT_DATE\n" > "$ROOT_DIR/$pkg/CHANGELOG.md"
        echo -e "$CHANGELOG_CONTENT" >> "$ROOT_DIR/$pkg/CHANGELOG.md"
    fi
done

# Verify that no path dependencies remain
echo -e "${BLUE}\n=== Verifying no path dependencies remain ===${NC}"
found_path_deps=false

for pkg in "${PACKAGES[@]}"; do
    if [ -f "$ROOT_DIR/$pkg/pubspec.yaml" ]; then
        if grep -q "path:" "$ROOT_DIR/$pkg/pubspec.yaml"; then
            echo -e "${RED}Warning: Path dependencies still found in $pkg/pubspec.yaml${NC}"
            echo -e "${YELLOW}Remaining path dependencies:${NC}"
            grep -A1 -B1 "path:" "$ROOT_DIR/$pkg/pubspec.yaml"
            found_path_deps=true
        else
            echo -e "${GREEN}✓ No path dependencies in $pkg${NC}"
        fi
    fi
done

if [ "$found_path_deps" = true ]; then
    echo -e "\n${RED}⚠️  Some packages still have path dependencies. Please review and fix manually.${NC}"
else
    echo -e "\n${GREEN}✅ All path dependencies successfully converted to versioned dependencies!${NC}"
fi

echo -e "${GREEN}All packages updated to version $VERSION with versioned dependencies${NC}"

# Automatically commit changes
echo -e "${BLUE}Committing changes...${NC}"
git add .
git commit -m "$COMMIT_MESSAGE" -m "$CHANGELOG_CONTENT"
echo -e "${GREEN}Changes committed successfully!${NC}"

echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. Run ./scripts/publish.sh to publish all packages in order"
echo -e ""
echo -e "${BLUE}To revert to development setup (path dependencies), use:${NC}"
echo -e "./scripts/restore_dev_setup.sh"
