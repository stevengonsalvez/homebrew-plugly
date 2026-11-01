cask "plugly" do
  arch arm: "arm64", intel: "x64"

  version "1.0.1"
  sha256 arm:   "a67af3473c707b32febe46ed6c611d618ad7dab1bc9eb18d4620acbb33b02a57",
         intel: "df50aa965982ce820b566c0cf8627520f3cae72e7157d7ff10dbde293a0dda0c"

  url "https://github.com/stevengonsalvez/plugly-releases/releases/download/v#{version}/plugly-macos-#{arch}.dmg"
  name "Plugly"
  desc "Run a fleet of coding agents side by side, each on its own branch"
  homepage "https://github.com/stevengonsalvez/plugly-releases"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app is Developer ID signed and notarized and installs its own updates (Squirrel.Mac), so
  # Homebrew leaves upgrades to it: `brew upgrade` skips the app unless --greedy.
  auto_updates true
  # Electron 38 and later need macOS 12.
  depends_on macos: :monterey

  app "Plugly.app"
  binary "#{appdir}/Plugly.app/Contents/Resources/bin/plugly"

  zap trash: [
    "~/.plugly",
    "~/Library/Application Support/Plugly",
    "~/Library/Caches/com.pluglyhq.plugly",
    "~/Library/HTTPStorages/com.pluglyhq.plugly",
    "~/Library/Preferences/com.pluglyhq.plugly.plist",
    "~/Library/Saved Application State/com.pluglyhq.plugly.savedState",
  ]

  caveats <<~EOS
    Plugly is Developer ID signed and notarized, and updates itself in-app.
    To update through Homebrew instead: brew upgrade --cask --greedy plugly
  EOS
end
