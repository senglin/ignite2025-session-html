#!/bin/bash
set -e

echo "🚀 Starting Ignite Session Viewer with nginx..."

# Check if nginx is installed
if ! command -v nginx &> /dev/null; then
    echo "❌ Error: nginx is not installed"
    echo "   Install it with: sudo apk add nginx"
    exit 1
fi

# Check if nginx is already running
if pgrep -x "nginx" > /dev/null; then
    echo "⚠️  nginx is already running"
    echo "   Use './scripts/restart.sh' to restart or './scripts/stop.sh' to stop"
    exit 0
fi

# Copy nginx config to a location nginx can read
NGINX_CONF="/workspaces/ignite2025-sessions-html/nginx.conf"

# Test nginx configuration
echo "🔍 Testing nginx configuration..."
if ! sudo nginx -t -c "$NGINX_CONF" 2>&1; then
    echo "❌ nginx configuration test failed"
    exit 1
fi

# Start nginx
echo "🏃 Starting nginx..."
sudo nginx -c "$NGINX_CONF"

# Wait for nginx to start
sleep 1

# Check if nginx is running
if pgrep -x "nginx" > /dev/null; then
    echo "✅ Server is running!"
    echo ""
    echo "🌐 Access the viewer at: http://localhost:8080"
    echo ""
    echo "📋 Useful commands:"
    echo "   - View logs:    tail -f /tmp/nginx_access.log"
    echo "   - Stop server:  ./scripts/stop.sh"
    echo "   - Restart:      ./scripts/restart.sh"
    echo "   - Status:       ./scripts/status.sh"
    echo ""
else
    echo "❌ Failed to start nginx"
    exit 1
fi
