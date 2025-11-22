#!/bin/bash
set -e

echo "🚀 Building and deploying Ignite Session Viewer..."
echo ""

# Build the project
./scripts/build.sh

echo ""
echo "🔄 Restarting nginx to serve the built version..."

# Check if nginx is running
if pgrep -x "nginx" > /dev/null; then
    ./scripts/restart.sh
else
    ./scripts/start.sh
fi

echo ""
echo "✅ Deployment complete!"
echo "🌐 The viewer is now serving the built version with embedded data at: http://localhost:8080"
