cask "eyehack" do
  version "0.1.18"
  sha256 "5c4dc8fd18a385a485acb08da7a533824d4a9a38b33f6bf0a5a1b2b41cc2dd30"

  url "https://github.com/romanrokon/eyehack/releases/download/v#{version}/EyeHack_#{version}_universal.dmg",
      verified: "github.com/romanrokon/eyehack/"
  name "EyeHack"
  desc "Eye breaks you can't snooze: every 20 minutes, 20 seconds of cats, nature or breathing"
  homepage "https://eyehack.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :ventura"

  app "EyeHack.app"

  # EyeHack is not notarized yet. Without this, macOS blocks the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/EyeHack.app"],
                   must_succeed: false
  end

  uninstall quit: "com.rzamann.eyehack"

  zap trash: [
    "~/Library/Application Support/com.rzamann.eyehack",
    "~/Library/Caches/com.rzamann.eyehack",
    "~/Library/Preferences/com.rzamann.eyehack.plist",
    "~/Library/WebKit/com.rzamann.eyehack",
  ]
end
