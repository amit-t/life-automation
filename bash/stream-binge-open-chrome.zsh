#!/bin/zsh

# Define an array of URLs
urls=(
    "https://www.netflix.com/browse"
    "https://www.primevideo.com/"
    "https://www.jiocinema.com/"
    "https://www.hotstar.com/in"
    "https://www.zee5.com/"
)

# Open each URL in a new tab in Chrome
for url in "${urls[@]}"; do
    open -a "Google Chrome" --new "$url"
    sleep 1  # Optional: brief pause to avoid overwhelming Chrome
done
