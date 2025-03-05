#!/bin/zsh
source ~/.zprofile
# Define an array of URLs
urls=(
    "https://www.netflix.com/browse"
    "https://www.primevideo.com/"
    "https://www.jiocinema.com/"
    "https://www.hotstar.com/in"
    "https://www.zee5.com/"
)

# Open each URL in a new tab if not already open
for url in "${urls[@]}"; do
    firefox -new-tab "$url" &
done