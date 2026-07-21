cask "football-menubar" do
  # ── VALUES YOU MUST UPDATE ON EACH RELEASE ─────────────────────────────
  # 1. Bump this to match the git tag you cut on the app repo (without the
  #    leading "v" — e.g. tag "v1.0.0" => version "1.0.0").
  version "1.0.0"

  # 2. Checksum of the release .zip. Generate it after building/zipping with:
  #      shasum -a 256 FootballMenuBar-1.0.0.zip
  #    Paste the hash below. While testing you MAY temporarily use
  #    `sha256 :no_check` to skip verification, but pin a real hash for release.
  sha256 "e183b53d2a2f0bb00216f8f95abf831f977a1a653d74bf18def518baf31b68c8"
  # ───────────────────────────────────────────────────────────────────────

  # Download URL for the release asset. This assumes the release workflow
  # attaches an asset named exactly "FootballMenuBar-<version>.zip" to a tag
  # named "v<version>" on the app repo. Adjust the filename here if your
  # build.sh names the zip differently.
  url "https://github.com/VillegasMich/football-tracker-menubar/releases/download/v#{version}/FootballMenuBar-#{version}.zip"

  name "Football Menu Bar"
  desc "Live football scores in your macOS menu bar"
  homepage "https://github.com/VillegasMich/football-tracker-menubar"

  # App is macOS 13 (Ventura) or later, per Package.swift / Info.plist.
  depends_on macos: ">= :ventura"

  # Name of the .app bundle inside the downloaded zip. Must match exactly what
  # build.sh produces (currently "FootballMenuBar.app").
  app "FootballMenuBar.app"

  # `brew uninstall --zap` also removes these. The plist name comes from the
  # bundle id in build.sh (BUNDLE_ID="com.local.footballmenubar").
  # TIP: consider changing that bundle id to reverse-DNS you actually own
  # (e.g. com.villegasmich.footballmenubar) before your first public release;
  # if you do, update the path below to match.
  zap trash: [
    "~/Library/Preferences/com.local.footballmenubar.plist",
  ]

  # ── GATEKEEPER NOTE (unsigned / ad-hoc build) ──────────────────────────
  # build.sh currently ad-hoc signs the app (`codesign --sign -`), NOT with a
  # Developer ID + notarization. Homebrew quarantines downloaded casks, so on
  # first launch macOS will block it as "unidentified developer".
  #
  # Until you notarize, either:
  #   • tell users to right-click the app in /Applications and choose "Open"
  #     the first time, OR
  #   • uncomment the caveats block below to surface the workaround, OR
  #   • strip quarantine automatically after install (uncomment postflight).
  #
  # caveats <<~EOS
  #   FootballMenuBar is not notarized yet. On first launch, right-click the
  #   app in /Applications and choose "Open", or run:
  #     xattr -dr com.apple.quarantine "/Applications/FootballMenuBar.app"
  # EOS
  #
  # postflight do
  #   system_command "/usr/bin/xattr",
  #                  args: ["-dr", "com.apple.quarantine",
  #                         "#{appdir}/FootballMenuBar.app"]
  # end
  # ───────────────────────────────────────────────────────────────────────
end
