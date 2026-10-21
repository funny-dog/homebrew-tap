# funny-dog Homebrew Tap

个人维护的 Homebrew Tap，用于安装 [FinderRight](https://github.com/funny-dog/FinderRight)。要求已安装 Homebrew、Apple Silicon Mac 和 macOS 13+。

```bash
brew install --cask funny-dog/tap/finderright
```

此命令安装 GitHub 正式 Release 中的原始 App，并校验下载文件的 SHA-256。当前 App 使用固定自签名证书，未经 Apple 公证；Tap 保留 macOS 隔离属性，不自动解除 Gatekeeper 拦截。

首次打开被拦截时，确认来自上述官方发布，先尝试打开 App，再前往「系统设置 → 隐私与安全性 → 仍要打开」。如选择终端方式，仅删除该 App 的隔离属性：

```bash
xattr -dr com.apple.quarantine /Applications/FinderRight.app
```

启动后仍需按应用引导启用 Finder 扩展，并按需授予完全磁盘访问、辅助功能权限。详细步骤见 [FinderRight 安装指南](https://github.com/funny-dog/FinderRight#-安装)。

## 更新与卸载

FinderRight 支持应用内更新。Cask 声明 `auto_updates true`，常规批量 `brew upgrade` 可能跳过这类应用；选择通过 Homebrew 更新时，先从菜单栏退出 FinderRight，再执行：

```bash
brew update
brew upgrade --cask --greedy funny-dog/tap/finderright
```

应用内更新不会同步 Homebrew 的安装版本记录；即使 App 已更新，Homebrew 仍可能按自己的记录重新安装。选择一种更新方式即可。更新后需重启 Finder，以加载新扩展；如系统再次拦截打开，按上述流程放行。

普通卸载保留设置和操作历史：

```bash
brew uninstall --cask funny-dog/tap/finderright
```

`brew uninstall --cask --zap funny-dog/tap/finderright` 还会删除配置、操作历史和应用暂存区。先完成或恢复暂存文件，再选择彻底清理；系统权限的清理见主项目卸载说明。

## 维护 Cask

1. 先发布 FinderRight 正式 Release，保持现有 ZIP 和 `.sha256` 资产名称及发布签名证书。
2. 下载对应版本的 `FinderRight-v<版本>.zip` 与 `.zip.sha256`，在下载目录运行 `shasum -a 256 -c FinderRight-v<版本>.zip.sha256`。Cask 的 `sha256` 必须对应 ZIP。
3. 更新 `Casks/finderright.rb` 中的 `version` 和 `sha256`；复核架构、最低系统版本、解压后 App 路径及签名。
4. 在已 tap 的环境运行 `brew style --cask funny-dog/tap/finderright`、`brew audit --cask funny-dog/tap/finderright` 和 `brew fetch --cask funny-dog/tap/finderright`，通过后提交并推送到 `main`。

个人 Tap 的常规审核不要求通过官方仓库的 Gatekeeper 收录检查。当前自签名版本不应宣称通过 Apple 公证或官方 Cask 的安全审核。

## English

Install FinderRight on an Apple Silicon Mac running macOS 13 or later:

```bash
brew install --cask funny-dog/tap/finderright
```

This tap installs the original GitHub release and verifies its SHA-256. FinderRight is self-signed, not Apple-notarized. Quarantine is preserved. If macOS blocks the first launch, try opening the app, then use **System Settings → Privacy & Security → Open Anyway** after checking the download source. Alternatively, remove only this app's quarantine attribute using the `xattr` command above. Enable the Finder extension and grant the required permissions using the app's setup guide.

FinderRight can update itself. With `auto_updates true`, normal bulk `brew upgrade` may skip it. For Homebrew-managed updates, quit FinderRight, run `brew update`, then `brew upgrade --cask --greedy funny-dog/tap/finderright`. In-app updates do not update Homebrew's version record, so Homebrew may reinstall an already updated app. Restart Finder after updating to load the new extension, and approve the app again if macOS blocks it.

`brew uninstall --cask funny-dog/tap/finderright` preserves settings and history. Adding `--zap` also deletes settings, operation history and staging files; finish or recover staged files before using it. See the main project for permission cleanup.

For a new release, update `version` and the ZIP checksum in `Casks/finderright.rb` after verifying the published ZIP against its `.sha256` file. Check architecture, minimum macOS, bundle path and signature; run the style, audit and fetch commands above, then commit and push to `main`.
