# wtree: Create a new worktree for each given branch.
# Usage: wtree [ -p|--pnpm ] [ -e|--editor <editor> ] branch1 branch2 ...
#
# This function does the following:
#   1. Parses command-line arguments; if -p/--pnpm is provided, it will later run "pnpm install".
#   2. Determines the current branch and repository root.
#   3. Uses a fixed parent directory (~/dev) to house all worktree directories.
#   4. For each branch passed:
#        - If the branch does not exist, it is created from the current branch.
#        - It checks that a worktree for that branch does not already exist.
#        - It then creates a worktree in ~/dev using a naming convention: <repoName>-<branch>.
#        - If the install-deps flag is true, it runs "pnpm install" inside the new worktree.
#        - Finally, it either opens the new worktree via the custom "cursor" command (if defined)
#          or prints its path.
# If the optional 'editor' argument is provided, it uses that as the command to open the new worktree;
# otherwise, it tries to run "cursor" with the new worktree as an argument.

wtree() {
  # Flag to determine whether to run "pnpm install"
  local install_deps=false
  local branches=()
  local editor="windsurf"

  # Parse command-line arguments
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -p|--pnpm)
        install_deps=true
        shift
        ;;
      -e|--editor)
        editor="$2"
        shift 2
        ;;
      *)
        branches+=("$1")
        shift
        ;;
    esac
  done

  # Ensure at least one branch name is provided.
  if [[ ${#branches[@]} -eq 0 ]]; then
    echo "Usage: wtree [ -p|--pnpm ] branch1 branch2 ..."
    return 1
  fi

  # Determine the current branch; exit if not in a git repository.
  local current_branch
  current_branch=$(git rev-parse --abbrev-ref HEAD) || {
    echo "Error: Not a git repository."
    return 1
  }

  # Determine repository root and name.
  local repo_root repo_name
  repo_root=$(git rev-parse --show-toplevel) || {
    echo "Error: Cannot determine repository root."
    return 1
  }
  repo_name=$(basename "$repo_root")

  # Set fixed parent directory for worktrees.
  local worktree_parent="$HOME/Projects/Worktrees"
  # Ensure the worktree parent directory exists.
  if [[ ! -d "$worktree_parent" ]]; then
    if ! mkdir -p "$worktree_parent"; then
      echo "Error: Failed to create worktree parent directory: $worktree_parent"
      return 1
    fi
  fi

  # Loop over each branch provided as argument.
  for branch in "${branches[@]}"; do
    # Define the target path using a naming convention: <repoName>-<branch>
    local target_path="$worktree_parent/${repo_name}-${branch}"
    
    echo "Processing branch: ${branch}"

    # Check if a worktree already exists at the target path.
    if git worktree list | grep -q "^${target_path}[[:space:]]"; then
      echo "Error: Worktree already exists at ${target_path}. Skipping branch '${branch}'."
      continue
    fi

    # If the branch does not exist, create it from the current branch.
    if ! git show-ref --verify --quiet "refs/heads/${branch}"; then
      echo "Branch '${branch}' does not exist. Creating it from '${current_branch}'..."
      if ! git branch "${branch}"; then
        echo "Error: Failed to create branch '${branch}'. Skipping."
        continue
      fi
    fi

    # Create the new worktree for the branch.
    echo "Creating worktree for branch '${branch}' at ${target_path}..."
    if ! git worktree add "$target_path" "${branch}"; then
      echo "Error: Failed to create worktree for branch '${branch}'. Skipping."
      continue
    fi

    # If the install flag is set, run "pnpm install" in the new worktree.
    if $install_deps; then
      echo "Installing dependencies in worktree for branch '${branch}'..."
      if ! ( cd "$target_path" && pnpm install ); then
        echo "Warning: Failed to install dependencies in '${target_path}'."
      fi
    fi

    # Optionally, open the worktree directory via a custom "cursor" command if available.
    if type cursor >/dev/null 2>&1; then
      $editor "$target_path"
    else
      echo "Worktree created at: ${target_path}"
    fi

    # Open the new worktree directory in a new tab in iTerm
    osascript <<EOF
    tell application "iTerm"
        activate
        tell current window
            create tab with default profile
            tell current session
                write text "cd '$target_path'"
            end tell
        end tell
    end tell
EOF

    echo "Worktree for branch '${branch}' created successfully."
    echo "-----------------------------------------------------"
  done
}