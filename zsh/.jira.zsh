#!/usr/bin/env zsh

# Base URL for Jira tickets
JIRA_BASE_URL="<JIRA_BASE_URL>/browse/"

# Function to open Jira tickets
function open_jira_ticket() {
  local ticket="$1"
  local url="${JIRA_BASE_URL}${ticket}"
  echo "Opening: $url"
  open "$url"
}

# Regular Jira command for backward compatibility
jira() {
  # If no arguments provided, print usage
  if [[ $# -eq 0 ]]; then
    echo "Usage: jira TICKET-ID [TICKET-ID ...]"
    echo "Example: jira SHELLPROD-7550 ICS-1231231"
    return 1
  fi

  # Process each ticket ID
  for ticket in "$@"; do
    open_jira_ticket "$ticket"
  done
}

# ZLE widget to detect and open Jira tickets
jira_ticket_widget() {
  # Get the current command line
  local cmd="$BUFFER"
  
  # Detect Jira ticket patterns: uppercase letters followed by dash and numbers
  if [[ "$cmd" =~ ^([A-Z]+-[0-9]+)$ ]]; then
    # Clear the command line
    BUFFER=""
    zle accept-line
    
    # Open the detected ticket
    open_jira_ticket "${match[1]}"
    return 0
  fi
  
  # If multiple tickets are detected, open all of them
  if [[ "$cmd" =~ ^([A-Z]+-[0-9]+)([[:space:]]+[A-Z]+-[0-9]+)+$ ]]; then
    # Clear the command line
    BUFFER=""
    zle accept-line
    
    # Split the tickets and open each one
    for ticket in ${(s: :)cmd}; do
      open_jira_ticket "$ticket"
    done
    return 0
  fi
  
  # If not a ticket pattern, continue with normal processing
  zle accept-line
}

# Create and bind the widget to Enter key
zle -N jira_ticket_widget
bindkey '^M' jira_ticket_widget
