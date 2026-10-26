cask "inkpot" do
  version "0.1.0"
  sha256 "95279f07d7e651e6b47d0861ff241da08e22e3dc6760c95ababa4d338d122ac1"

  url "https://github.com/funny-dog/inkpot/releases/download/v#{version}/Inkpot-v#{version}.zip"
  name "Inkpot"
  desc "Lightweight Markdown editor for daily Chinese writing, built on MarkEdit"
  homepage "https://inkpot.erhuerhu.dpdns.org/"

  depends_on macos: :sequoia

  app "Inkpot.app"

  # 自签名未公证，只删隔离属性，免去首次打开时手动放行
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Inkpot.app"]
  end

  zap trash: [
    "~/Library/Application Support/Inkpot",
    "~/Library/Caches/com.erhu.inkpot",
    "~/Library/Preferences/com.erhu.inkpot.plist",
    "~/Library/Saved Application State/com.erhu.inkpot.savedState",
    "~/Library/WebKit/com.erhu.inkpot",
  ]

  caveats <<~EOS
    Inkpot is self-signed and is not notarized by Apple.
    This cask removes the com.apple.quarantine attribute from
    Inkpot.app after installation, so macOS does not run the
    Gatekeeper first-launch check for this app.

    Quit Inkpot and save your documents before upgrading or
    reinstalling it with Homebrew. Inkpot can download updates
    but does not install them. Let Homebrew manage installation:
    brew upgrade --cask inkpot.

    User Markdown documents are never touched by uninstall or zap.
  EOS
end
