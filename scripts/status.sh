#!/bin/bash

echo "📊 Ignite Session Viewer - Status"
echo "=================================="
echo ""

# Check if nginx is installed
if ! command -v nginx &> /dev/null; then
    echo "❌ nginx is not installed"
    exit 1
fi

# Check if nginx is running
if pgrep -x "nginx" > /dev/null; then
    echo "✅ nginx is RUNNING"
    echo ""
    echo "Process information:"
    ps aux | grep "[n]ginx" | head -5
    echo ""
    echo "Listening ports:"
    sudo netstat -tlnp 2>/dev/null | grep nginx || sudo lsof -i :8080 2>/dev/null || echo "Port information not available"
    echo ""
    echo "🌐 Access the viewer at: http://localhost:8080"
else
    echo "❌ nginx is NOT RUNNING"
    echo "   Start it with: ./scripts/start.sh"
fi

echo ""
echo "📝 Recent access logs:"
echo "=================================="
if [ -f /tmp/nginx_access.log ]; then
    tail -20 /tmp/nginx_access.log 2>/dev/null || echo "No access logs available"
else
    echo "No access logs available"
fi

echo ""
echo "📝 Recent error logs:"
echo "=================================="
if [ -f /tmp/nginx_error.log ]; then
    tail -10 /tmp/nginx_error.log 2>/dev/null || echo "No error logs"
else
    echo "No error logs"
fi
