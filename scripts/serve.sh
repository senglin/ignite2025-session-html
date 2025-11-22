#!/bin/bash
set -e

PORT=8080

echo "🚀 Starting Ignite Session Viewer (simple HTTP server)..."
echo ""

# Check for available HTTP servers
if command -v python3 &> /dev/null; then
    echo "✅ Using Python 3 HTTP server"
    echo "🌐 Server running at: http://localhost:$PORT"
    echo "   Press Ctrl+C to stop"
    echo ""
    python3 -m http.server $PORT
elif command -v python &> /dev/null; then
    echo "✅ Using Python 2 HTTP server"
    echo "🌐 Server running at: http://localhost:$PORT"
    echo "   Press Ctrl+C to stop"
    echo ""
    python -m SimpleHTTPServer $PORT
elif command -v php &> /dev/null; then
    echo "✅ Using PHP built-in server"
    echo "🌐 Server running at: http://localhost:$PORT"
    echo "   Press Ctrl+C to stop"
    echo ""
    php -S localhost:$PORT
elif command -v busybox &> /dev/null; then
    echo "✅ Using BusyBox HTTP server"
    echo "🌐 Server running at: http://localhost:$PORT"
    echo "   Press Ctrl+C to stop"
    echo ""
    busybox httpd -f -p $PORT
else
    echo "❌ No HTTP server found. Please install one of:"
    echo "   - Python 3"
    echo "   - PHP"
    echo "   - Node.js (npx serve)"
    echo ""
    echo "Or use Docker: ./scripts/start.sh"
    exit 1
fi
