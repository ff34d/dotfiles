# ============================================================ 
# ENVIRONMENT VARIABLES & PATHS 
# ============================================================ 
export EDITOR="vim" # Default editor

# Homebrew configuration
export HOMEBREW_NO_AUTO_UPDATE=1      # Disable auto updates
export HOMEBREW_NO_ANALYTICS=1        # Disable analytics
export HOMEBREW_NO_ENV_HINTS=1        # Disable version clues
export HOMEBREW_NO_INSTALL_CLEANUP=1  # Disable service messages

# Android sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

# ============================================================ 
# TERMINAL HISTORY CONFIGURATION
# ============================================================ 
HISTFILE="$HOME/.zsh_history" # History file path
HISTSIZE=100                  # History size in memory
SAVEHIST=1000                 # History size of lines in saving file
SHELL_SESSION_HISTORY=0       # Disable session history saving

# History options
setopt HIST_IGNORE_DUPS       # Ignore empty lines
setopt HIST_IGNORE_SPACE      # Ignore empty lines witch spaces


# ============================================================ 
# ALIASES 
# ============================================================ 
# Default
alias ls="ls -a -G --color=auto"
alias ll="eza -al --icons --no-user --no-permissions --no-time" 
alias lk="eza -alTL 2 --icons --no-user --no-permissions --no-time" 
alias grep="grep --color=auto"
alias cat="bat"

# Git
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"

# ============================================================ 
# Initialization
# ============================================================ 
eval "$(starship init zsh)"   # Initialize starship
eval "$(mise activate zsh)"   # Initialize mise

# Initialize auto complete menu
autoload -Uz compinit
compinit
