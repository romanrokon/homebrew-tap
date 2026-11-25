cask "eyehack" do
  version "0.1.19"
  sha256 "0b9a4d0187230f178bd017bd6fded6ed8ba205b634a71306caac720277f620fe"

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
