#!/bin/bash

# ---------------------
# Sync Custom ZSH Aliases
# ---------------------

# Alias list
declare -a aliases=(
    # Basic
    "alias c='clear'"
    "alias l='ls -lah'"

    # Docker
    "alias docup='docker compose up'"
    "alias docupd='docker compose up -d'"

    # Node
    "alias nap='node app.js'"
    "alias tap='ts-node app.ts'"

    # NPM
    "alias ni='npm i'"
    "alias nil='npm i --legacy-peer-deps'"
    "alias nrn='if [ -d \"./node_modules\" ]; then rm -rf \"./node_modules\"; echo \"Removed ./node_modules directory\"; fi; if [ -f \"./package-lock.json\" ]; then rm \"./package-lock.json\"; echo \"Removed ./package-lock.json file\"; fi'"

    # NPM General Scripts
    "alias nrd='npm run dev'"
    "alias nrs='npm run start'"

    # PNPM
    "alias pi='pnpm i'"
    "alias piw='pnpm i --workspace-root'"
    "alias prn='if [ -d \"./node_modules\" ]; then rm -rf \"./node_modules\"; echo \"Removed ./node_modules directory\"; fi; if [ -f \"./pnpm-lock.yaml\" ]; then rm \"./pnpm-lock.yaml\"; echo \"Removed ./pnpm-lock.yaml file\"; fi'"

    # PNPM General Scripts
    "alias prd='pnpm dev'"
    "alias prs='pnpm start'"
    "alias prt='pnpm test'"
    "alias prb='pnpm build'"

    # Composer
    "alias ci='composer install'"
    "alias cu='composer update'"
    "alias ct='composer test'"
    "alias crv='if [ -d \"./vendor\" ]; then rm -rf \"./vendor\"; echo \"Removed ./vendor directory\"; fi; if [ -f \"./composer.lock\" ]; then rm \"./composer.lock\"; echo \"Removed ./composer.lock file\"; fi'"

    # Angular
    "alias ngs='ng serve --host 0.0.0.0 --port 4200 --disable-host-check --live-reload=false'"
    "alias ngss='ng serve --host 0.0.0.0 --port 4444 --disable-host-check --live-reload=false'"

    # Laravel
    "alias pak='php artisan key:generate'"
    "alias pas='php artisan serve --port=8000'"
    "alias pass='php artisan serve --port=9000'"
    "alias pam='php artisan migrate'"
    "alias pamf='php artisan migrate:fresh'"
    "alias pamfs='php artisan migrate:fresh --seed'"
    "alias pamr='php artisan migrate:rollback'"
    "alias paop='php artisan optimize'"
    "alias paopc='php artisan optimize:clear'"
    "alias pat='php artisan test'"

    # Claude
    "alias cc='claude'"
    "alias ccd='claude --dangerously-skip-permissions'"
)

# .zshrc file path
zshrc_file="$HOME/.zshrc"

# Backup the current .zshrc file
backup_file="$HOME/.zshrc.bak"
cp "$zshrc_file" "$backup_file"

# Create a temporary file for the new aliases
temp_file=$(mktemp)

# Append existing content of the .zshrc file to the temporary file
cat "$backup_file" >"$temp_file"

# Check if the region tags exist
if grep -q "#region dev aliases" "$zshrc_file"; then
    # Remove existing region content, but keep the region tags
    sed -i '' "/#region dev aliases/,/#endregion/d" "$temp_file"
fi

# Add the region start and end tags and aliases to the temporary file
echo "#region dev aliases" >>"$temp_file"

# Add aliases to the temporary file
for alias_cmd in "${aliases[@]}"; do
    echo "$alias_cmd" >>"$temp_file"
done

echo "#endregion" >>"$temp_file"

# Replace the old .zshrc file with the new content
mv "$temp_file" "$zshrc_file"

# Remove the backup file
rm "$backup_file"

# Source the .zshrc file to apply changes
source "$zshrc_file"

# Reload the terminal profile
exec zsh
