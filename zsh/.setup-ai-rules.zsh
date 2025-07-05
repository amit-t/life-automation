function car() {
  # Define the source directory - you'll need to update this path
  local source_dir="$HOME/Projects/Scripts/life-automation/ai-rules"
  
  # Define the destination directory in the current working directory
  local dest_dir="$(pwd)/.ai-rules"
  
  # Check if source directory exists
  if [[ ! -d "$source_dir" ]]; then
    echo "Error: Source directory '$source_dir' does not exist."
    return 1
  fi
  
  # Create destination directory if it doesn't exist
  if [[ ! -d "$dest_dir" ]]; then
    mkdir -p "$dest_dir"
    echo "Created destination directory: $dest_dir"
  fi
  
  # Copy contents from source to destination
  rsync -av --progress "$source_dir/" "$dest_dir/"
  
  if [[ $? -eq 0 ]]; then
    echo "Successfully copied ai-rules to $dest_dir"
    return 0
  else
    echo "Failed to copy ai-rules to $dest_dir"
    return 1
  fi
}