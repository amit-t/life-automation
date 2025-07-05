#!/bin/zsh
#
# Git account helper functions
# Makes cloning repositories with multiple GitHub accounts easier
#

# Function for the 'at' account
function git-at() {
  local repo_url=$1
  
  if [[ -z "$repo_url" ]]; then
    echo "Error: Repository URL is required"
    echo "Usage: git-at <repository-url>"
    return 1
  fi
  
  # Transform URL to use github.com-at host if needed
  if [[ $repo_url == *"github.com:"* ]]; then
    repo_url=${repo_url/github.com:/github.com-at:}
  elif [[ $repo_url == *"github.com/"* ]]; then
    repo_url=${repo_url/github.com\//github.com-at:}
    # Convert https:// format to SSH format
    if [[ $repo_url == https* ]]; then
      repo_url="git@${repo_url#https://}"
      # Replace / with : after the domain
      repo_url=${repo_url/github.com-at\//github.com-at:}
    fi
  fi
  
  # Clone the repository
  echo "Cloning: $repo_url"
  git clone $repo_url
  
  # Get the directory name from the URL
  local repo_dir=$(basename "$repo_url" .git)
  
  # Enter the directory if it exists
  if [[ -d "$repo_dir" ]]; then
    echo "Changing to directory: $repo_dir"
    cd "$repo_dir"
  else
    echo "Warning: Could not determine repository directory name"
  fi
}

# Function for the 'atv' account
function git-atv() {
  local repo_url=$1
  
  if [[ -z "$repo_url" ]]; then
    echo "Error: Repository URL is required"
    echo "Usage: git-atv <repository-url>"
    return 1
  fi
  
  # Transform URL to use github.com-atv host if needed
  if [[ $repo_url == *"github.com:"* ]]; then
    repo_url=${repo_url/github.com:/github.com-atv:}
  elif [[ $repo_url == *"github.com/"* ]]; then
    repo_url=${repo_url/github.com\//github.com-atv:}
    # Convert https:// format to SSH format
    if [[ $repo_url == https* ]]; then
      repo_url="git@${repo_url#https://}"
      # Replace / with : after the domain
      repo_url=${repo_url/github.com-atv\//github.com-atv:}
    fi
  fi
  
  # Clone the repository
  echo "Cloning: $repo_url"
  git clone $repo_url
  
  # Get the directory name from the URL
  local repo_dir=$(basename "$repo_url" .git)
  
  # Enter the directory if it exists
  if [[ -d "$repo_dir" ]]; then
    echo "Changing to directory: $repo_dir"
    cd "$repo_dir"
  else
    echo "Warning: Could not determine repository directory name"
  fi
}

# Function to add a new account helper
# Usage: add-git-account <suffix>
function add-git-account() {
  local suffix=$1
  
  if [[ -z "$suffix" ]]; then
    echo "Error: Account suffix is required"
    echo "Usage: add-git-account <suffix>"
    return 1
  fi
  
  # Check if function already exists
  if typeset -f "git-$suffix" > /dev/null; then
    echo "Function git-$suffix already exists"
    return 1
  fi
  
  # Create the new function
  eval "function git-$suffix() { 
    local repo_url=\$1
    
    if [[ -z \"\$repo_url\" ]]; then
      echo \"Error: Repository URL is required\"
      echo \"Usage: git-$suffix <repository-url>\"
      return 1
    fi
    
    # Transform URL to use github.com-$suffix host if needed
    if [[ \$repo_url == *\"github.com:\"* ]]; then
      repo_url=\${repo_url/github.com:/github.com-$suffix:}
    elif [[ \$repo_url == *\"github.com/\"* ]]; then
      repo_url=\${repo_url/github.com\\//github.com-$suffix:}
      # Convert https:// format to SSH format
      if [[ \$repo_url == https* ]]; then
        repo_url=\"git@\${repo_url#https://}\"
        # Replace / with : after the domain
        repo_url=\${repo_url/github.com-$suffix\\//github.com-$suffix:}
      fi
    fi
    
    # Clone the repository
    echo \"Cloning: \$repo_url\"
    git clone \$repo_url
    
    # Get the directory name from the URL
    local repo_dir=\$(basename \"\$repo_url\" .git)
    
    # Enter the directory if it exists
    if [[ -d \"\$repo_dir\" ]]; then
      echo \"Changing to directory: \$repo_dir\"
      cd \"\$repo_dir\"
    else
      echo \"Warning: Could not determine repository directory name\"
    fi
  }"
  
  echo "Function git-$suffix has been created"
}

# Print available git account helpers
function list-git-accounts() {
  echo "Available git account helpers:"
  functions | grep "^git-" | sort
}

# Function to set and export GitHub token from .paths_profile
function set-ght() {
  # Extract the token from .paths_profile
  local token_line=$(grep 'export GITHUB_TOKEN=' "$HOME/Profiles/.paths_profile")
  
  if [[ -z "$token_line" ]]; then
    echo "Error: GitHub token not found in .paths_profile"
    return 1
  fi
  
  # Extract the token value
  local token=$(echo "$token_line" | sed 's/export GITHUB_TOKEN="\(.*\)"/\1/')
  
  if [[ -z "$token" ]]; then
    echo "Error: Could not extract GitHub token value"
    return 1
  fi
  
  # Export the token
  export GITHUB_TOKEN="$token"
  echo "GitHub token has been set and exported"
  echo "Token: ${token:0:6}...${token: -4}"
}

# Function to unset GitHub token
function unset-ght() {
  if [[ -z "$GITHUB_TOKEN" ]]; then
    echo "GitHub token is not currently set"
  else
    local token_preview="${GITHUB_TOKEN:0:6}...${GITHUB_TOKEN: -4}"
    unset GITHUB_TOKEN
    echo "GitHub token has been unset ($token_preview)"
  fi
}
