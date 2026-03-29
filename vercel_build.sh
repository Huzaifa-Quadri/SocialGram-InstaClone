#!/bin/bash
# Install Flutter SDK on Vercel
if cd flutter; then
    git pull && cd ..
else
    git clone https://github.com/flutter/flutter.git -b stable
fi

# Show flutter version and doctor summary
flutter/bin/flutter doctor -v

# Enable web support (just in case)
flutter/bin/flutter config --enable-web

# Clean old builds
flutter/bin/flutter clean

# Get dependencies
flutter/bin/flutter pub get

# Build the web app
flutter/bin/flutter build web --release

# The output folder `build/web` must be configured in Vercel settings as the Output Directory.
