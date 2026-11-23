cask "swiftflash" do
  version "1.0.1"
  sha256 "60285c9496b4f89e5f6b424c7bbebbbb4645e0ca2238ec5b61c8a3365826ebb9"

  url "https://github.com/funny-dog/SwiftFlash/releases/download/v#{version}/SwiftFlash-v#{version}.zip"
  name "SwiftFlash"
  desc "Fast native code editor built with Swift, AppKit, and CoreText"
  homepage "https://github.com/funny-dog/SwiftFlash"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "SwiftFlash.app"

  # 自签名未公证，只删隔离属性，免去首次打开时手动放行
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/SwiftFlash.app"]
  end

  zap trash: [
    "~/Library/Application Support/SwiftFlash",
    "~/Library/Preferences/dev.swiftflash.ide.plist",
  ]

  caveats <<~EOS
    SwiftFlash is self-signed and is not notarized by Apple.
    This cask removes the com.apple.quarantine attribute from
    SwiftFlash.app after installation, so macOS does not run the
    Gatekeeper first-launch check for this app.

    Quit SwiftFlash before upgrading or reinstalling it with Homebrew.
  EOS
end
