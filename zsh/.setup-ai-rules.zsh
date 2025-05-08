function car() {
  # Define the source directory - you'll need to update this path
  local source_dir="$HOME/Projects/Scripts/life-automation/ai-rules"
  
  # Define the destination directory as the current working directory
  local dest_dir="$(pwd)"
  local windsurfrules_file="$dest_dir/.windsurfrules"
  
  # Check if source directory exists
  if [[ ! -d "$source_dir" ]]; then
    echo "Error: Source directory '$source_dir' does not exist."
    return 1
  fi
  
  # Move all files from source to .windsurf/rules in the destination
  local windsurf_rules_dir="$dest_dir/.windsurf/rules"
  if [[ ! -d "$windsurf_rules_dir" ]]; then
    mkdir -p "$windsurf_rules_dir"
    echo "Created destination directory: $windsurf_rules_dir"
  fi

  local count=0
  for file in "$source_dir"/*; do
    if [[ -f "$file" ]]; then
      cp "$file" "$windsurf_rules_dir/"
      ((count++))
    fi
  done

  if [[ $count -eq 0 ]]; then
    echo "No files were moved."
    return 1
  fi

  echo "Successfully moved $count files to $windsurf_rules_dir"
  

  
  return 0
}