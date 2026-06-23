# Changelog

All notable changes to Squintless are documented here. This project follows [Semantic Versioning](https://semver.org).

## [1.1.1] - 2026-06-23

### Fixed
- ccstatusline statusline colors are now legible in both light and dark. Switched to ANSI-16 (`colorLevel` 1), so colors track the active terminal scheme instead of a fixed 256-color palette, and replaced the low-contrast `brightBlack` segments with `white`. Every segment now clears WCAG AA on both Squintless palettes.

### Added
- **Scoop** install: `scoop install squintless` via the bundled manifest.
- **Short install URLs** through a Cloudflare Worker: `irm https://sameerzahir.com/sq | iex` (Windows) and `curl -fsSL https://sameerzahir.com/sh | bash` (macOS/Linux), transparent 302 redirects to the raw install scripts on `main`.
- `CONTRIBUTING.md`, `SECURITY.md`, and GitHub issue / pull-request templates.

### Changed
- Release publishing now uses `Publish-PSResource` (PSResourceGet) so the PowerShell Gallery push runs unattended in CI.
- Docs: the short URLs are the headline one-liners; `worker/README` reflects the now-live custom-domain routes.

## [1.1.0] - 2026-06-23

Initial public release.

### Added
- One-command, eye-strain-optimized terminal + Claude Code setup for **Windows, macOS and Linux**.
- Two cohesive palettes: **Gruvbox light** and **Tokyo Night Moon dark**.
- Windows installer (`install.ps1`) with non-destructive Windows Terminal fragment delivery; cross-platform installer (`install.sh`) for kitty / WezTerm / Alacritty / Ghostty / iTerm2 and zsh / bash.
- Single-source color generator (`palettes/*.json` → `tools/gen.py` → `config/generated/**`) with a computed WCAG contrast table.
- JetBrains Mono Nerd Font, an oh-my-posh prompt, git-delta, and a curated ccstatusline.
- PowerShell Gallery module (`Install-Module Squintless`), a Claude Code plugin, and CI (PSScriptAnalyzer + Pester on Windows; shellcheck + bats on Ubuntu & macOS).
- Idempotent, fully reversible installs (`-Uninstall` / `--uninstall`); every touched file is backed up first.

[1.1.1]: https://github.com/sameer-zahir/squintless/releases/tag/v1.1.1
[1.1.0]: https://github.com/sameer-zahir/squintless/releases/tag/v1.1.0
