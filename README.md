# VillegasMich Homebrew Tap

Homebrew casks for my macOS apps.

## Install

```sh
brew tap VillegasMich/tap
brew install --cask football-menubar
```

`brew tap VillegasMich/tap` resolves to this repo (`homebrew-tap`); the
`homebrew-` prefix is required by Homebrew and stripped in the command.

## Available casks

| Cask | Description |
| --- | --- |
| `football-menubar` | Live football scores in your macOS menu bar |

## Updating

```sh
brew upgrade --cask football-menubar
```

## Maintainer notes

> Day-to-day app development happens in the app repo — build and run the app
> directly there with `./build.sh && open FootballMenuBar.app`. The steps below
> are only for verifying that the **published cask** installs the released build
> correctly, before pushing this tap to everyone.

### Cutting a release

Each app release requires updating its cask in `Casks/`:

1. In the app repo, bump the version and build the zip:
   `VERSION=1.2.3 ./build.sh` (prints the `sha256` at the end).
2. Cut a GitHub Release tagged `v<version>` with `FootballMenuBar-<version>.zip`
   attached. Pushing the `v*` tag triggers the release workflow, which builds
   and attaches the zip automatically.
3. In `Casks/football-menubar.rb`, bump `version` and paste the new `sha256`.
   (The `url` uses `#{version}`, so it updates itself.)
4. Commit and push this repo.

### Testing a release locally before publishing

Homebrew can treat a local clone of this repo as the tap, so you can install and
verify the cask without pushing anything public.

**One-time setup** — point the tap name at this local folder:

```sh
brew untap VillegasMich/tap 2>/dev/null   # remove any existing (remote) tap
brew tap VillegasMich/tap /Users/manuel.villegas/Documents/Personal/homebrew-tap
brew trust VillegasMich/tap               # local taps require an explicit trust
```

> Note: `brew tap <name> <path>` uses the folder as a git **remote** and clones
> it — so only *committed* changes are visible to Homebrew, not your working
> tree.

**Each iteration** — after editing the cask, commit, refresh Homebrew's clone,
then reinstall:

```sh
git add Casks/football-menubar.rb && git commit -m "…"   # in this repo
git -C "$(brew --repository VillegasMich/tap)" pull       # pull into brew's clone
brew reinstall --cask football-menubar
open /Applications/FootballMenuBar.app
```

Validate the cask (audit **by name** — the old file-path form is disabled):

```sh
brew audit --cask VillegasMich/tap/football-menubar
brew style VillegasMich/tap/football-menubar
```

The audit downloads the release zip to verify its `sha256`, so the matching
GitHub Release must already be published (step 2 above).

**Switch back to the public tap** when you're done testing:

```sh
brew untap VillegasMich/tap
brew tap VillegasMich/tap                  # clones from GitHub
```
