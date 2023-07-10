#!/bin/bash
# MP3 YouTube Downloader
# Author: kipmyk
# Date: 2023-07-10
# Decription: This script downloads a YouTube video as an MP3 file
# Usage instructions
# 1. Make sure you have an active internet connection.
# 2. Run this script in the Terminal.
# 3. Enter the YouTube video URL when prompted.
# 4. Enter the path to save the MP3 file when prompted.
#    (Example: /path/to/save/directory)
# 5. Wait for the script to download and convert the video to MP3.
# 6. The MP3 file will be saved in the specified path with the title of the video as the filename.
#    (Example: /path/to/save/directory/Video_Title.mp3)
# 7. Enjoy your downloaded MP3 file!

# Prompt for the YouTube video URL
echo "Enter the YouTube video URL:"
read video_url

# Prompt for the save path
echo "Enter the path to save the MP3 file:"
read save_path

# Check if youtube-dl is installed
if ! command -v youtube-dl &> /dev/null; then
  echo "youtube-dl is not installed. Installing it now..."
  
  # Check if Homebrew is installed
  if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing it now..."
    
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  
  # Install youtube-dl using Homebrew
  brew install youtube-dl
  
  echo "youtube-dl has been installed."
fi

# Download the video as an MP3 file
youtube-dl -x --audio-format mp3 -o "$save_path/%(title)s.%(ext)s" $video_url
