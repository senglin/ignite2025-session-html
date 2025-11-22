#!/bin/bash
set -e

echo "🔨 Building Ignite Session Viewer..."

# Define paths
BUILD_DIR="/workspaces/ignite2025-sessions-html/build"
SOURCE_HTML="/workspaces/ignite2025-sessions-html/index.html"
SOURCE_JSON="/workspaces/ignite2025-sessions-html/sessions.json"
OUTPUT_HTML="$BUILD_DIR/index.html"

# Create build directory
echo "📁 Creating build directory..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Check if sessions.json exists
if [ ! -f "$SOURCE_JSON" ]; then
    echo "⚠️  Warning: sessions.json not found. Building without embedded data."
    echo "   The viewer will only support manual file loading."
    cp "$SOURCE_HTML" "$OUTPUT_HTML"
    echo "✅ Build complete (no embedded data)"
    echo "📦 Output: $OUTPUT_HTML"
    exit 0
fi

echo "📊 Reading sessions.json..."
JSON_SIZE=$(wc -c < "$SOURCE_JSON")
echo "   Size: $JSON_SIZE bytes"

# Create the output HTML with embedded data
echo "🔧 Embedding sessions.json into HTML..."

# Use Python to inject the JSON directly into the HTML file
python3 << 'PYTHON_EOF'
import json
import sys

try:
    # Read sessions data
    with open('/workspaces/ignite2025-sessions-html/sessions.json', 'r') as f:
        sessions_data = json.load(f)
    
    # Read source HTML
    with open('/workspaces/ignite2025-sessions-html/index.html', 'r') as f:
        html_content = f.read()
    
    # Find the <script> tag and inject the embedded data
    script_tag = '<script>'
    injection_point = html_content.find(script_tag)
    
    if injection_point == -1:
        print("Error: Could not find <script> tag", file=sys.stderr)
        sys.exit(1)
    
    # Create the embedded data declaration
    embedded_js = "\n    // Embedded session data (generated at build time)\n"
    embedded_js += "    var EMBEDDED_SESSIONS_DATA = " + json.dumps(sessions_data, separators=(',', ':')) + ";\n\n"
    
    # Insert the embedded data right after the <script> tag
    insertion_point = injection_point + len(script_tag)
    modified_html = html_content[:insertion_point] + embedded_js + html_content[insertion_point:]
    
    # Write to output file
    with open('/workspaces/ignite2025-sessions-html/build/index.html', 'w') as f:
        f.write(modified_html)
    
    print("✅ Successfully embedded sessions data", file=sys.stderr)
    
except Exception as e:
    print(f"Error: {e}", file=sys.stderr)
    sys.exit(1)
PYTHON_EOF

if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to generate output HTML"
    exit 1
fi

# Verify the output
if [ ! -f "$OUTPUT_HTML" ]; then
    echo "❌ Error: Output file was not created"
    exit 1
fi

OUTPUT_SIZE=$(wc -c < "$OUTPUT_HTML")
echo "✅ Build complete!"
echo ""
echo "📊 Build Summary:"
echo "   Input HTML:  $(wc -c < "$SOURCE_HTML") bytes"
echo "   Sessions JSON: $JSON_SIZE bytes"
echo "   Output HTML: $OUTPUT_SIZE bytes"
echo ""
echo "📦 Output location: $OUTPUT_HTML"
echo "🌐 To serve: Update nginx.conf root to $BUILD_DIR and restart"
