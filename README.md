# funny-dog Homebrew Tap

个人维护的 Homebrew Tap，用于安装 [FinderRight](https://github.com/funny-dog/FinderRight) 与 [Inkpot](https://github.com/funny-dog/inkpot)。要求已安装 Homebrew；FinderRight 需要 Apple Silicon Mac 和 macOS 13+，Inkpot 需要 macOS 15+。

## FinderRight

```bash
brew install --cask funny-dog/tap/finderright
```

此命令安装 GitHub 正式 Release 中的原始 App，并校验下载文件的 SHA-256。当前 App 使用固定自签名证书，未经 Apple 公证；为免去首次打开时的手动放行，Cask 在安装后执行以下命令，仅删除该 App 的隔离属性，macOS 因此不再对它做 Gatekeeper 首次打开检查：

```bash
xattr -dr com.apple.quarantine /Applications/FinderRight.app
```

如希望保留系统检查，请改用主项目的 DMG 安装。启动后仍需按应用引导启用 Finder 扩展，并按需授予完全磁盘访问、辅助功能权限。详细步骤见 [FinderRight 安装指南](https://github.com/funny-dog/FinderRight#-安装)。

### 更新与卸载

FinderRight 支持应用内更新。Cask 声明 `auto_updates true`，常规批量 `brew upgrade` 可能跳过这类应用；选择通过 Homebrew 更新时，先从菜单栏退出 FinderRight，再执行：

```bash
brew update
brew upgrade --cask --greedy funny-dog/tap/finderright
```

应用内更新不会同步 Homebrew 的安装版本记录；即使 App 已更新，Homebrew 仍可能按自己的记录重新安装。选择一种更新方式即可。通过 Homebrew 更新同样会删除隔离属性。更新后需重启 Finder，以加载新扩展。

普通卸载保留设置和操作历史：

```bash
brew uninstall --cask funny-dog/tap/finderright
```

`brew uninstall --cask --zap funny-dog/tap/finderright` 还会删除配置、操作历史和应用暂存区。先完成或恢复暂存文件，再选择彻底清理；系统权限的清理见主项目卸载说明。

## Inkpot

```bash
brew install --cask funny-dog/tap/inkpot
```

此命令安装 GitHub 正式 Release 中的原始 App（Universal，支持 Apple Silicon 与 Intel），并校验下载文件的 SHA-256。Inkpot 使用固定自签名证书，未经 Apple 公证；为免去首次打开时的手动放行，Cask 在安装后仅删除该 App 的隔离属性，macOS 因此不再对它做 Gatekeeper 首次打开检查：

```bash
xattr -dr com.apple.quarantine /Applications/Inkpot.app
```

如希望保留系统检查，请改用主项目 Release 页的 DMG 安装，首次打开在「系统设置 → 隐私与安全性」点「仍要打开」。

### 更新与卸载

Inkpot 可以自动检查并下载安装包，但不会自动安装或替换应用，更新安装交给 Homebrew 即可：

```bash
brew update
brew upgrade --cask inkpot
```

升级前正常退出 Inkpot 并保存文档。如曾从发布页手动下载覆盖安装到 `/Applications`，再执行一次上面的升级命令即可让 Homebrew 的版本记录重新对齐。通过 Homebrew 更新同样会删除隔离属性。

普通卸载保留设置与文档恢复数据：

```bash
brew uninstall --cask funny-dog/tap/inkpot
```

`brew uninstall --cask --zap funny-dog/tap/inkpot` 还会删除设置、缓存与 WebKit 本地数据；卸载与 zap 都不会碰用户的 Markdown 文档本身。

## 维护 Cask

1. 先发布对应项目的正式 Release，保持现有 ZIP 和 `.sha256` 资产名称及发布签名证书。
2. 下载对应版本的 `FinderRight-v<版本>.zip` / `Inkpot-v<版本>.zip` 与 `.zip.sha256`，在下载目录运行 `shasum -a 256 -c <资产名>.zip.sha256`。Cask 的 `sha256` 必须对应 ZIP。
3. 更新 `Casks/finderright.rb` / `Casks/inkpot.rb` 中的 `version` 和 `sha256`；复核架构、最低系统版本、解压后 App 路径及签名。
4. 在已 tap 的环境运行 `brew style --cask funny-dog/tap/<名称>`、`brew audit --cask funny-dog/tap/<名称>` 和 `brew fetch --cask funny-dog/tap/<名称>`，通过后提交并推送到 `main`。

个人 Tap 的常规审核不要求通过官方仓库的 Gatekeeper 收录检查；官方仓库不接受删除隔离属性的 Cask。当前自签名版本不应宣称通过 Apple 公证或官方 Cask 的安全审核。

## English

Install FinderRight on an Apple Silicon Mac running macOS 13 or later:

```bash
brew install --cask funny-dog/tap/finderright
```

This tap installs the original GitHub release and verifies its SHA-256. FinderRight is self-signed, not Apple-notarized. To skip manual first-launch approval, the cask runs the `xattr` command above after installation, removing only this app's quarantine attribute, so macOS does not run the Gatekeeper first-launch check for it. To keep that check, install the DMG from the main project instead. Enable the Finder extension and grant the required permissions using the app's setup guide.

FinderRight can update itself. With `auto_updates true`, normal bulk `brew upgrade` may skip it. For Homebrew-managed updates, quit FinderRight, run `brew update`, then `brew upgrade --cask --greedy funny-dog/tap/finderright`. In-app updates do not update Homebrew's version record, so Homebrew may reinstall an already updated app. Homebrew updates also remove the quarantine attribute. Restart Finder after updating to load the new extension.

`brew uninstall --cask funny-dog/tap/finderright` preserves settings and history. Adding `--zap` also deletes settings, operation history and staging files; finish or recover staged files before using it. See the main project for permission cleanup.

Install Inkpot on a Mac running macOS 15 or later (Universal, both Apple Silicon and Intel):

```bash
brew install --cask funny-dog/tap/inkpot
```

This tap installs the original GitHub release and verifies its SHA-256. Inkpot is self-signed, not Apple-notarized. To skip manual first-launch approval, the cask removes only this app's quarantine attribute after installation, so macOS does not run the Gatekeeper first-launch check for it. To keep that check, install the DMG from the project's release page and click "Open Anyway" under System Settings → Privacy & Security on first launch.

Inkpot can check for and download updates, but does not install them. Let Homebrew manage installation: run `brew update`, then `brew upgrade --cask inkpot`. Quit Inkpot and save your documents before upgrading. If you manually installed a newer build over `/Applications/Inkpot.app`, run the upgrade command once to realign Homebrew's version record. Homebrew updates also remove the quarantine attribute.

`brew uninstall --cask funny-dog/tap/inkpot` preserves settings and document-recovery data. Adding `--zap` also deletes settings, caches and local WebKit data. Uninstall and zap never touch your Markdown documents.

For a new release, update `version` and the ZIP checksum in the matching `Casks/*.rb` after verifying the published ZIP against its `.sha256` file. Check architecture, minimum macOS, bundle path and signature; run the style, audit and fetch commands above, then commit and push to `main`.
