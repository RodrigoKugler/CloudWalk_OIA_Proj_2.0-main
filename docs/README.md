# CloudWalk Q1 2025 Strategic Analysis - GitHub Pages Site

This directory contains the GitHub Pages presentation site for the CloudWalk Operational Intelligence Q1 2025 Strategic Analysis.

## Site Structure

- **index.html** - Landing page with executive summary, key metrics, and strategic priorities overview
- **findings.html** - Detailed strategic findings with collapsible technical sections
- **insights.html** - Business questions (Q1-Q6) with visualizations and strategic context
- **methodology.html** - Technical details: data quality, calculation methods, assumptions
- **styles.css** - CloudWalk fintech theme styling
- **script.js** - Interactive functionality (collapsible sections, lightbox, navigation)

## GitHub Pages Setup

This site is configured to deploy automatically via GitHub Actions when changes are pushed to the `main` branch.

### Manual Setup (if needed)

1. Go to your repository Settings → Pages
2. Under "Source", select "GitHub Actions"
3. The site will deploy from the `docs/` folder

### Local Testing

To test locally before deploying:

1. Use a local server (required for proper path resolution):
   ```bash
   # Python 3
   cd docs
   python -m http.server 8000
   
   # Node.js (if you have http-server installed)
   npx http-server docs -p 8000
   ```
2. Open `http://localhost:8000` in your browser

## Features

- ✅ Modern fintech design with CloudWalk color theme
- ✅ Responsive layout (mobile-friendly)
- ✅ Collapsible sections for technical details
- ✅ Image lightbox for visualizations
- ✅ Smooth scrolling navigation
- ✅ Multi-page structure for easy navigation
- ✅ Embedded visualizations with click-to-expand

## Visualizations

Visualizations are referenced from `../outputs/visualizations/findings/`. Make sure these files exist in the repository for images to display correctly.

## Browser Support

- Chrome/Edge (latest)
- Firefox (latest)
- Safari (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## Notes

- All image paths are relative to the `docs/` folder
- Links to full README.md use `../README.md` (one level up)
- GitHub Pages will serve this from the repository root URL when configured

