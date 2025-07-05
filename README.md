# Life Automation Scripts

A collection of automation scripts to streamline various tasks and improve workflow efficiency. These scripts handle everything from development workflows to application management and media streaming.

## Table of Contents

- [Installation](#installation)
- [Scripts](#scripts)
  - [Jira Ticket Helper](#jira-ticket-helper)
  - [Work Tree Manager](#work-tree-manager)
  - [Application Management](#application-management)
  - [Media Streaming](#media-streaming)
  - [System Maintenance](#system-maintenance)
  - [AI Rules](#ai-rules)
- [Usage](#usage)
- [Contribution](#contribution)

## Installation

1. Clone this repository to your local machine:

```bash
git clone https://github.com/amit-t/life-automation.git
```

2. Add the following to your `.zshrc` or `.bashrc` file to source all scripts:

```bash
# Source life-automation scripts
for file in ~/Projects/Scripts/life-automation/zsh/*.zsh; do
  source "$file"
done
for file in ~/Projects/Scripts/life-automation/zsh/.*.zsh; do
  source "$file"
done
```

3. Reload your shell configuration:

```bash
source ~/.zshrc  # or source ~/.bashrc
```

## Scripts

### Jira Ticket Helper

The `.jira.zsh` script provides easy access to Jira tickets directly from your terminal.

#### Features:
- Open Jira tickets by simply typing the ticket ID in your terminal
- Support for opening multiple tickets at once

#### Usage:
```bash
# Open a single ticket
TICKET-123

# Open multiple tickets
TICKET-123 TICKET-456

# Or simply type the ticket ID and press Enter
TICKET-123
```

### Work Tree Manager

The `.wtree.zsh` script streamlines Git worktree management.

#### Features:
- Create worktrees for multiple branches in one command
- Automatically install dependencies with the `-p` flag
- Open the new worktree in your preferred editor

#### Usage:
```bash
# Create a worktree for a branch
wtree branch-name

# Create a worktree and install dependencies with pnpm
wtree -p branch-name

# Create multiple worktrees at once
wtree branch1 branch2 branch3

# Specify a different editor to open the worktree
wtree -e vscode branch-name
```

### Application Management

Scripts to manage applications, particularly for restarting problematic apps:

- `restart-crashed-station.zsh`: Restarts the Station app when it crashes with improved error handling and diagnostics
- `restart-new-station.zsh`: Starts a fresh instance of Station with enhanced startup parameters

#### Usage:
```bash
# Restart a crashed Station app
./zsh/restart-crashed-station.zsh

# Start a fresh Station instance
./zsh/restart-new-station.zsh
```

### Media Streaming

Scripts to quickly open streaming services in your preferred browser:

- `stream-binge-open-chrome.zsh`: Opens streaming services in Chrome
- `stream-binge-open-firefox.zsh`: Opens streaming services in Firefox

#### Usage:
```bash
# Open streaming services in Chrome
./zsh/stream-binge-open-chrome.zsh

# Open streaming services in Firefox
./zsh/stream-binge-open-firefox.zsh
```

### System Maintenance

Scripts for system maintenance tasks:

- `zcompdump-cleanup.zsh`: Cleans up zsh completion cache files to prevent issues with shell completion

#### Usage:
```bash
# Clean zsh completion cache files
./zsh/zcompdump-cleanup.zsh
```

### AI Rules

The `.setup-ai-rules.zsh` script helps you set up AI coding assistant rules for your projects. This script copies TypeScript coding guidelines from the repository to your current project.

#### Features:
- Automatically copies AI rules to a `.ai-rules` directory in your current project
- Provides best practices for TypeScript development
- Includes rules for types, interfaces, enums, error handling, and more

#### Usage:
```bash
# Navigate to your TypeScript project directory
cd path/to/your/project

# Copy AI rules to your project
car
```

#### Available Rules:
- Type definitions and usage
- Interface extensions
- Enum implementation
- Default exports
- Import type statements
- JSDoc comments
- Naming conventions
- Error handling
- And more

## Contribution

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/my-new-script`
3. Commit your changes: `git commit -am 'Add a new automation script'`
4. Push to the branch: `git push origin feature/my-new-script`
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
