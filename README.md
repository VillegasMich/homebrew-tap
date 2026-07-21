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

Each release of an app requires updating its cask in `Casks/`:

1. Build and zip the `.app` in the app repo.
2. Cut a GitHub Release with the zip attached (tag `v<version>`).
3. In the cask file, bump `version` and paste the new `sha256`
   (`shasum -a 256 <zip>`).
4. Commit and push this repo.

Validate a cask locally before pushing:

```sh
brew audit --cask --new Casks/football-menubar.rb
brew style Casks/football-menubar.rb
```
