#!/usr/bin/env bats
# Sandboxed install/idempotency/uninstall tests for install.sh. Each test runs in a
# throwaway $HOME with git's global config redirected, so nothing leaks to the runner.

setup() {
  TMPH="$(mktemp -d)"
  export HOME="$TMPH"
  export GIT_CONFIG_GLOBAL="$TMPH/.gitconfig"
  export SHELL="/bin/bash"
  REPO="$(cd "$BATS_TEST_DIRNAME/.." && pwd)"
}

teardown() { rm -rf "$TMPH"; }

@test "install (--skip-deps --light --yes) writes init.sh, omp theme, one rc marker" {
  run bash "$REPO/install.sh" --skip-deps --light --yes
  [ "$status" -eq 0 ]
  [ -f "$TMPH/.config/squintless/init.sh" ]
  [ -f "$TMPH/.config/ohmyposh/squintless.omp.json" ]
  [ "$(grep -c '>>> squintless' "$TMPH/.bashrc")" -eq 1 ]
}

@test "install is idempotent across re-runs and a variant switch" {
  bash "$REPO/install.sh" --skip-deps --light --yes
  bash "$REPO/install.sh" --skip-deps --dark --yes
  [ "$(grep -c '>>> squintless' "$TMPH/.bashrc")" -eq 1 ]
}

@test "dark variant bakes the dark omp theme + TwoDark bat theme" {
  run bash "$REPO/install.sh" --skip-deps --dark --yes
  [ "$status" -eq 0 ]
  [ -f "$TMPH/.config/ohmyposh/squintless.dark.omp.json" ]
  grep -q 'TwoDark' "$TMPH/.config/squintless/init.sh"
}

@test "git-delta is configured and dark sets delta.dark" {
  bash "$REPO/install.sh" --skip-deps --dark --yes
  run git config --global delta.dark
  [ "$status" -eq 0 ]
  [ "$output" = "true" ]
}

@test "uninstall reverses the install" {
  bash "$REPO/install.sh" --skip-deps --light --yes
  run bash "$REPO/install.sh" --uninstall
  [ "$status" -eq 0 ]
  [ ! -f "$TMPH/.config/squintless/init.sh" ]
  run grep -c '>>> squintless' "$TMPH/.bashrc"
  [ "$output" = "0" ]
}
