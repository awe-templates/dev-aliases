# Dev Aliases

Command aliases for JavaScript/Node Full-Stack developers. Saves time by replacing long commands with short ones. Fork and customize for your own workflow.

## Installation

### Windows (PowerShell)

Run the sync script to add all aliases to your PowerShell profile:

```powershell
. .\src\windows\sync.ps1
```

Restart PowerShell or run `. $PROFILE` to apply changes.

### macOS (Zsh)

Run the sync script to add all aliases to your zsh profile:

```bash
sh src/macos/sync.sh
```

Terminal will restart automatically to apply changes.

## Available Aliases

| Alias | Command | Category |
|-------|---------|----------|
| `c` | Clear screen | Basic |
| `l` | List files with details | Basic |
| `docup` | `docker compose up` | Docker |
| `docupd` | `docker compose up -d` | Docker |
| `nap` | `node app.js` | Node |
| `tap` | `ts-node app.ts` | Node |
| `ni` | `npm i` | NPM |
| `nil` | `npm i --legacy-peer-deps` | NPM |
| `nrn` | Remove node_modules & package-lock.json | NPM |
| `nrd` | `npm run dev` | NPM |
| `nrs` | `npm run start` | NPM |
| `pi` | `pnpm i` | PNPM |
| `piw` | `pnpm i --workspace-root` | PNPM |
| `prn` | Remove node_modules & pnpm-lock.yaml | PNPM |
| `prd` | `pnpm dev` | PNPM |
| `prs` | `pnpm start` | PNPM |
| `prt` | `pnpm test` | PNPM |
| `prb` | `pnpm build` | PNPM |
| `up` | `pnpm self-update` | PNPM |
| `ci` | `composer install` | Composer |
| `cu` | `composer update` | Composer |
| `ct` | `composer test` | Composer |
| `crv` | Remove vendor & composer.lock | Composer |
| `ngs` | `ng serve` (port 4200) | Angular |
| `ngss` | `ng serve` (port 4444) | Angular |
| `pak` | `php artisan key:generate` | Laravel |
| `pas` | `php artisan serve` (port 8000) | Laravel |
| `pass` | `php artisan serve` (port 9000) | Laravel |
| `pam` | `php artisan migrate` | Laravel |
| `pamf` | `php artisan migrate:fresh` | Laravel |
| `pamfs` | `php artisan migrate:fresh --seed` | Laravel |
| `pamr` | `php artisan migrate:rollback` | Laravel |
| `paop` | `php artisan optimize` | Laravel |
| `paopc` | `php artisan optimize:clear` | Laravel |
| `pat` | `php artisan test` | Laravel |
| `pint` | `./vendor/bin/pint` | Laravel |
| `phps` | `php -S 127.0.0.1:8000 index.php` | PHP |
| `phpfix` | `php vendor/bin/php-cs-fixer fix ./` | PHP |
| `phpstan` | `./vendor/bin/phpstan analyse` | PHP |
| `cc` | `claude` | Claude |
| `ccd` | `claude --dangerously-skip-permissions` | Claude |
