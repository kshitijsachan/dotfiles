#!/usr/bin/env bash
# Opinionated macOS defaults. Run once; some need a logout to fully apply.
set -euo pipefail

# Keyboard: fast repeat, and hold-to-repeat instead of the accent popup (matters for hjkl)
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15
defaults write -g ApplePressAndHoldEnabled -bool false

# Trackpad: tap to click, three-finger drag
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Dock: auto-hide instantly, no recent apps
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock show-recents -bool false

# AeroSpace recommendations: group windows by app in Mission Control,
# one Space spanning all displays, Ctrl-Cmd-drag to move windows from anywhere
defaults write com.apple.dock expose-group-apps -bool true
defaults write com.apple.spaces spans-displays -bool true
defaults write -g NSWindowShouldDragOnGesture -bool true

# Finder: show hidden files, extensions, path bar; search the current folder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXDefaultSearchScope -string SCcf

# Screenshots go to their own folder
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"

killall Dock Finder SystemUIServer 2>/dev/null || true
echo "Done. Log out and back in for keyboard/trackpad/Spaces changes."
