# Microsoft Ignite 2025 Session Viewer

A lightweight, client-side web application for browsing and exploring Microsoft Ignite 2025 sessions with on-demand videos and slide decks.

## Overview

This single-page HTML application provides an intuitive interface to view and filter Microsoft Ignite 2025 conference sessions. Load the sessions JSON data via drag-and-drop or file picker, then browse sessions organized by availability of on-demand videos and presentation slide decks.

## Features

- 🎯 **Client-side processing** – No server required, runs entirely in the browser
- 📂 **Drag & Drop support** – Simply drop your JSON file onto the page
- 🎬 **On-Demand Videos** – Browse sessions with available video recordings
- 📊 **Slide Decks** – Find sessions with downloadable presentation slides
- 🎨 **Clean, modern UI** – Responsive design with intuitive navigation
- 🔍 **Session details** – View descriptions, speakers, duration, and metadata
- 📱 **Mobile-friendly** – Works on desktop and mobile browsers

## Getting Started

### Prerequisites

- A modern web browser (Chrome, Firefox, Safari, or Edge)
- Internet connection (for loading Handlebars library from CDN)
- **For nginx deployment:** nginx installed (`sudo apk add nginx` on Alpine)

### Quick Start

**Recommended: Build with embedded data**
```bash
# Download the latest session data
curl -o sessions.json "https://api-v2.ignite.microsoft.com/api/session/all/en-US"

# Build and deploy (embeds data into HTML + starts nginx)
./scripts/deploy.sh

# The viewer will be available at http://localhost:8080
# Sessions load automatically from embedded data!
```

**Alternative: Start without building**
```bash
# Option 1: nginx server (production-ready)
./scripts/start.sh

# Option 2: Simple HTTP server
./scripts/serve.sh

# Both serve on http://localhost:8080
# You can drag/drop a sessions.json file to load data
```

**nginx management commands:**
```bash
./scripts/stop.sh      # Stop the server
./scripts/restart.sh   # Restart/reload the server
./scripts/status.sh    # Check server status and logs
```

### Manual Usage (without scripts)

1. **Get the sessions data:**
   - Open [https://api-v2.ignite.microsoft.com/api/session/all/en-US](https://api-v2.ignite.microsoft.com/api/session/all/en-US) in your browser
   - Save the JSON response as `ignite-sessions.json`
   
   Or use curl:
   ```bash
   curl -o ignite-sessions.json "https://api-v2.ignite.microsoft.com/api/session/all/en-US"
   ```

2. **Open the viewer:**
   - Open `index.html` in your web browser
   - Or use a local server:
     ```bash
     python -m http.server 8000
     # Then visit http://localhost:8000
     ```

3. **Load the data:**
   - Drag and drop `ignite-sessions.json` onto the drop zone, or
   - Click "Choose a file" and select the JSON file

4. **Explore sessions:**
   - Switch between tabs to view sessions with videos or slide decks
   - Click session links to watch videos or download slides

## Project Structure

```
ignite2025-sessions-html/
├── .devcontainer/
│   └── devcontainer.json          # Dev container configuration
├── .github/
│   └── prompts/
│       ├── commit.prompt          # Git commit message generator prompt
│       ├── download_ignite2025.prompt.md  # Helper prompt for data retrieval
│       └── files/
│           ├── file.json          # Sample session data
│           └── style.png          # Reference image
├── build/                         # Build output (generated)
│   └── index.html                 # Built HTML with embedded sessions data
├── scripts/
│   ├── build.sh                   # Build project (embed sessions.json into HTML)
│   ├── deploy.sh                  # Build and deploy to nginx
│   ├── start.sh                   # Start nginx server
│   ├── stop.sh                    # Stop nginx server
│   ├── restart.sh                 # Restart/reload nginx server
│   ├── status.sh                  # Check server status and logs
│   └── serve.sh                   # Simple HTTP server (alternative)
├── nginx.conf                     # nginx server configuration
├── index.html                     # Source HTML file
├── sessions.json                  # Session data (download from API)
└── README.md                      # This file
```

## Development

### Dev Container

This project includes a dev container configuration for consistent development environments:

```bash
# Open in VS Code with Dev Containers extension
code .
# Reopen in Container when prompted
```

The dev container includes:
- Alpine Linux 3.20 base
- Docker extension
- Data preview extensions
- Git visualization tools

### Build Process

The project uses a build system to embed session data directly into the HTML:

**Build workflow:**
```bash
# 1. Download session data
curl -o sessions.json "https://api-v2.ignite.microsoft.com/api/session/all/en-US"

# 2. Build the project (embeds sessions.json into index.html)
./scripts/build.sh

# Output: build/index.html (with embedded data, ~5MB)
```

**Or use the deploy script (build + restart nginx):**
```bash
./scripts/deploy.sh
```

### Data Loading Priority

The viewer implements a 3-tier fallback system:

1. **User-provided file** (drag & drop or file picker) - Highest priority
2. **sessions.json** in the same directory - Fallback #1
3. **Embedded data** in the built HTML - Fallback #2

This ensures the viewer always works, even without network access or external files.

### Local Development

**Development mode (source files):**
```bash
# Edit index.html and serve directly
./scripts/serve.sh

# Or point nginx to source directory
# (Edit nginx.conf: root /workspaces/ignite2025-sessions-html)
```

**Production mode (built files):**
```bash
# Edit index.html, rebuild, and deploy
./scripts/build.sh
./scripts/restart.sh

# Or use the combined command
./scripts/deploy.sh
```

**Server management:**
```bash
./scripts/start.sh      # Start nginx
./scripts/stop.sh       # Stop nginx
./scripts/restart.sh    # Reload configuration
./scripts/status.sh     # View status and logs
```

### nginx Configuration

The `nginx.conf` includes:
- Gzip compression for better performance
- Security headers (X-Frame-Options, X-Content-Type-Options, X-XSS-Protection)
- Appropriate caching strategies for HTML and static assets
- JSON content type handling
- Custom error pages
- Serves files from project directory directly

## Technology Stack

- **HTML5** – Semantic markup
- **CSS3** – Modern styling with flexbox and grid
- **Vanilla JavaScript** – No frameworks, pure JS
- **Handlebars.js** – Client-side templating (loaded from CDN)

## Browser Compatibility

- Chrome/Edge 90+
- Firefox 88+
- Safari 14+
- Any modern browser with ES6 support

## Data Source

Session data is retrieved from the official Microsoft Ignite API:
```
https://api-v2.ignite.microsoft.com/api/session/all/en-US
```

## Contributing

This is a demonstration project. Feel free to fork and adapt for your own needs.

## License

This project is provided as-is for educational and demonstration purposes.

## Acknowledgments

Built for Microsoft Ignite 2025 attendees and developers exploring conference sessions programmatically.

---

**Note:** This viewer is not officially affiliated with Microsoft. Session data is sourced from the public Ignite API.
