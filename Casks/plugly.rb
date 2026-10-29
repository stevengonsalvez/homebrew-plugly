cask "plugly" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0"
  sha256 arm:   "07b5c4e286a6b776db3b50b2be05af33d2708455f58dc8d65b0bcebfdac64050",
         intel: "5c754ea6a27bf664b7760d5cafd089709c67b936498f257ab9b1b3f23033901e"

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
  depends_on macos: ">= :monterey"

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
