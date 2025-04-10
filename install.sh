#!/bin/zsh

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change the .npm directory to a new path

# Run the npm.sh script in the same directory
chmod +x "$SCRIPT_DIR/npm.sh"
bash "$SCRIPT_DIR/npm.sh"


# export 
export NVM_DIR="$HOME/goinfre/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



nvm install node 


# Prepend the desired directory to the PATH
NODE_VERSION=$(nvm current)
export PATH="/home/tel-mouh/goinfre/.nvm/versions/node/$NODE_VERSION/bin:$PATH"

# Check the current shell
CURRENT_SHELL=$(basename "$SHELL")
CURRENT_SHELLRC="$HOME/.$CURRENT_SHELL""rc"

# Create the .npm directory if it doesn't exist
mkdir -p "$HOME/goinfre/.npm"

# Export NPM_CONFIG_CACHE and add it to the shell rc file
export NPM_CONFIG_CACHE="$HOME/goinfre/.npm"
echo "export NPM_CONFIG_CACHE=\"$HOME/goinfre/.npm\"" >> $CURRENT_SHELLRC

# Add the PATH modification to ~/.zshrc and ~/.bashrc
echo "export PATH=\"$HOME/goinfre/.nvm/versions/node/\$(nvm current)/bin:\$PATH\"" >> $CURRENT_SHELLRC


EXPECTED_CACHE_PATH="$HOME/goinfre/.npm"
ACTUAL_CACHE_PATH=$(npm config get cache)

if [ "$ACTUAL_CACHE_PATH" = "$EXPECTED_CACHE_PATH" ]; then
  echo -e "\033[0;32mNPM cache is correctly set to $ACTUAL_CACHE_PATH\033[0m"
else
  echo -e "\033[0;31mNPM cache is not correctly set. Current value: $ACTUAL_CACHE_PATH\033[0m"
fi


npm -g install npm@latest




exec $CURRENT_SHELL