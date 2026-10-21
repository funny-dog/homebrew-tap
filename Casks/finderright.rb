cask "finderright" do
  version "1.10.1"
  sha256 "7cfeef08c6816bd7cf418fb837f2d0cb366fd037f7e9ffca4b8e00c614f96b5b"

  url "https://github.com/funny-dog/FinderRight/releases/download/v#{version}/FinderRight-v#{version}.zip"
  name "FinderRight"
  desc "Finder context menu with file templates, terminals, and cut and paste"
  homepage "https://github.com/funny-dog/FinderRight"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "FinderRight.app"

  # 自签名未公证，只删隔离属性，免去首次打开时手动放行
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/FinderRight.app"]
  end

  zap trash: [
    "~/Library/Application Support/FinderRight",
    "~/Library/Preferences/com.finderright.app.plist",
  ]

  caveats <<~EOS
    FinderRight is self-signed and is not notarized by Apple.
    This cask removes the com.apple.quarantine attribute from
    FinderRight.app after installation, so macOS does not run the
    Gatekeeper first-launch check for this app.

    Follow the app's setup guide to enable its Finder extension and permissions.
    Full Disk Access is needed for protected folders; Accessibility is needed
    to toggle hidden files without restarting Finder.

    Quit FinderRight before upgrading or reinstalling it with Homebrew.
    After updating, restart Finder to load the new extension.
    Setup instructions:
      https://github.com/funny-dog/FinderRight#-安装
  EOS
end
