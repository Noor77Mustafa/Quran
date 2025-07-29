#!/bin/bash

echo "🚀 MyQuran App Store Deployment Preparation"
echo "=============================================="

# Generate icons
echo "📱 Generating app icons..."
if [ -f scripts/generate-icons.js ]; then
  node scripts/generate-icons.js
else
  echo "Skipping icon generation (scripts/generate-icons.js not found)"
fi

# Build the application
echo "🏗️  Building application..."
npm run build

# Check TypeScript
echo "✅ Type checking..."
npm run check

# Create deployment package
echo "📦 Creating deployment package..."
mkdir -p app-store-package
if [ ! -d dist ]; then
  echo "Error: build output directory 'dist' not found." >&2
  exit 1
fi
cp -r dist/* app-store-package/
if [ -d public ]; then
  cp public/manifest.json app-store-package/
  cp public/icon*.svg app-store-package/
else
  echo "Warning: public directory not found, skipping manifest and icons" >&2
fi
cp app-store-config.json app-store-package/
cp deploy-app-store.md app-store-package/

echo "✨ App store package created successfully!"
echo ""
echo "📋 Next steps:"
echo "1. Deploy to production domain (use Replit Deploy)"
echo "2. Test PWA functionality"
echo "3. Install PWA Builder CLI: npm install -g @pwabuilder/cli"
echo "4. Generate app packages: pwabuilder https://your-app-url.com"
echo "5. Submit to app stores"
echo ""
echo "📁 Package location: ./app-store-package/"
echo "📖 Full guide: ./deploy-app-store.md"
