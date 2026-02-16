#!/bin/bash

# Script to update all Cursor skill files to reference the correct project structure
# Run this from your project root: bash update-skill-references.sh

SKILLS_DIR="$HOME/.cursor/skills"

echo "Updating skill file references in $SKILLS_DIR..."
echo ""

# Check if skills directory exists
if [ ! -d "$SKILLS_DIR" ]; then
    echo "❌ Error: Cursor skills directory not found at $SKILLS_DIR"
    exit 1
fi

# Find all .mdc files in the skills directory and subdirectories
find "$SKILLS_DIR" -name "*.mdc" -type f | while read -r file; do
    # Check if file contains any context/ references
    if grep -q "context/" "$file"; then
        echo "Updating: $(basename "$file")"
        
        # Create backup
        cp "$file" "$file.backup"
        
        # Update all context references
        sed -i '' \
            -e 's/`context\/company\.md`/`projects\/company-context\/`/g' \
            -e 's/`context\/product\.md`/`projects\/product-artifacts\/`/g' \
            -e 's/`context\/personas\.md`/`projects\/personas\/personas.md`/g' \
            -e 's/`context\/competitors\.md`/`projects\/competitors\/competitors.md`/g' \
            -e 's/context\/company\.md/projects\/company-context\//g' \
            -e 's/context\/product\.md/projects\/product-artifacts\//g' \
            -e 's/context\/personas\.md/projects\/personas\/personas.md/g' \
            -e 's/context\/competitors\.md/projects\/competitors\/competitors.md/g' \
            "$file"
        
        echo "  ✅ Updated (backup saved as $(basename "$file").backup)"
    fi
done

echo ""
echo "🎉 Done! All skill references have been updated to match your project structure."
echo ""
echo "Mappings applied:"
echo "  context/company.md     → projects/company-context/"
echo "  context/product.md     → projects/product-artifacts/"
echo "  context/personas.md    → projects/personas/personas.md"
echo "  context/competitors.md → projects/competitors/competitors.md"
echo ""
echo "Note: Backups of original files saved with .backup extension"
