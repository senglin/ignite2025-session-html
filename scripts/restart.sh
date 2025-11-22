#!/bin/bash
set -e

echo "🔄 Restarting Ignite Session Viewer..."

# Check if nginx is running
if ! pgrep -x "nginx" > /dev/null; then
    echo "⚠️  nginx is not running, starting it..."
    ./scripts/start.sh
    exit 0
fi

# Test nginx configuration
NGINX_CONF="/workspaces/ignite2025-sessions-html/nginx.conf"
echo "🔍 Testing nginx configuration..."
if ! sudo nginx -t -c "$NGINX_CONF" 2>&1; then
    echo "❌ nginx configuration test failed"
    exit 1
fi

# Reload nginx configuration
echo "🔄 Reloading nginx..."
sudo nginx -c /workspaces/ignite2025-sessions-html/nginx.conf -s reload

echo "✅ Server restarted successfully"
echo "🌐 Access the viewer at: http://localhost:8080"
