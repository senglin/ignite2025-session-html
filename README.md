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

### Usage

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
├── index.html                     # Main application file
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

### Local Development

No build process required! Simply edit `index.html` and refresh your browser.

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
