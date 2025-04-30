#!/bin/zsh
source ~/Profiles/.zprofile
# Function to close an application
close_app() {
    local app_name="$1"
    osascript -e "tell application \"$app_name\" to quit"
    echo "$app_name closed."
}

# Function to open an application
open_app() {
    local app_name="$1"
    open -a "$app_name"
    echo "$app_name opened."
}

# Function to make an app fullscreen
make_fullscreen() {
    local app_name="$1"
    osascript -e "tell application \"$app_name\" to activate" \
               -e "tell application \"System Events\" to keystroke \"f\" using {control down, command down}"
    echo "$app_name set to fullscreen."
}

# Function to disable fullscreen
disable_fullscreen() {
    local app_name="$1"
    osascript -e "tell application \"$app_name\" to activate" \
               -e "tell application \"System Events\" to keystroke \"f\" using {control down, command down}"
    echo "$app_name fullscreen disabled."
}

# Function to kill an application
kill_app() {
    local app_name="$1"
    pkill "$app_name"
    echo "$app_name killed."
}

function restart-crashed-station() {
    # Application name
    APP_NAME="Station"

    kill_app "$APP_NAME"
    sleep 5  # Wait for the action to complete

    kill_app "$APP_NAME"
    sleep 5  # Wait for the action to complete

    # Step 5: Reopen the application
    open_app "$APP_NAME"
    sleep 5  # Wait for the action to complete

    # Step 4: Disable fullscreen and kill the app
    disable_fullscreen "$APP_NAME"
    sleep 5  # Wait for the action to complete

    # Step 4: Disable fullscreen and kill the app
    disable_fullscreen "$APP_NAME"
    sleep 5  # Wait for the action to complete

    # close_app "$APP_NAME"
    # sleep 2  # Wait for the action to complete

    kill_app "$APP_NAME"
    sleep 5  # Wait for the action to complete

    kill_app "$APP_NAME"
    sleep 5  # Wait for the action to complete

    # Step 5: Reopen the application
    open_app "$APP_NAME"
    sleep 5

    # Step 4: Disable fullscreen and kill the app
    make_fullscreen "$APP_NAME"
    sleep 5
}


