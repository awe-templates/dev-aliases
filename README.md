# dev-aliases

My command aliases required for a Javascript/Node Full-Stack developers (*of course you can modify commands with by forking for yourself*). Why we need this? To save time and avoid typing long commands. This is a collection of my aliases for different platforms.

## Installation Windows

### Step 1: Pull the files

- Go to the root folder of the `C:\` drive (or whatever your root folder is) then create `aliases` folder
- Clone this repository to the `aliases` folder (hint: use `git clone https://github.com/relliv/dev-aliases`)

### Step 2: Define environment variables

- Press `Win Key + S` and search for `Environment Variables`
- Click `Environment Variables...` button (right bottom)
- In `System Variables` section find `Path` record and open with double click
- Press `New` button and add new record as your aliases folder path
- Confirm all screen with `OK` button

### Apply changes

- Restart your all CMD and PowerShell instances
- Also when you add new command `alias.bat` you may need to restart your CMD and PowerShell instances

See more info: [Source](https://stackoverflow.com/a/39459404/6940144)

### Usage

Long command is `php artisan serve`. Short command is `pas`. We are calling aliases by file name.

## Installation Linux

... (WIP)

## Installation MacOS

> [!WARNING]  
> This script created for automatic alias sync to your **zsh** profile. You need to backup your `/Users/{username}/.zshrc` file before run sync script.

Run sync command:

```bash
sh src/macos/sync.sh
```
