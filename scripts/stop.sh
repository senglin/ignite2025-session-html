#!/bin/bash
set -e

echo "🛑 Stopping Ignite Session Viewer..."

# Check if nginx is running
if ! pgrep -x "nginx" > /dev/null; then
    echo "⚠️  nginx is not running"
    exit 0
fi

# Stop nginx
sudo nginx -s stop 2>/dev/null || sudo pkill -9 nginx

# Wait for nginx to stop
sleep 1

# Verify nginx is stopped
if ! pgrep -x "nginx" > /dev/null; then
    echo "✅ Server stopped successfully"
else
    echo "⚠️  nginx may still be running, trying force kill..."
    sudo pkill -9 nginx
    echo "✅ Server stopped"
fi
