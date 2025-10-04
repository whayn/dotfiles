#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO="https://github.com/whayn/dotfiles.git"
GIT_DIR="$HOME/.dotfiles"
WORK_TREE="$HOME"
BACKUP_DIR="$HOME/.dotfiles-backup"

# helper to run git against the bare repo
config() {
  git --git-dir="$GIT_DIR" --work-tree="$WORK_TREE" "$@"
}

# clone if needed
if [ ! -d "$GIT_DIR" ]; then
  git clone --bare "$DOTFILES_REPO" "$GIT_DIR"
else
  echo "Using existing bare repo at $GIT_DIR"
fi

mkdir -p "$BACKUP_DIR"

# try checkout; if it fails, parse conflicting filenames robustly and back them up
if config checkout 2>/dev/null; then
  echo "Checked out dotfiles from $DOTFILES_REPO"
else
  echo "Checkout failed — backing up conflicting files to $BACKUP_DIR"

  # run checkout once and capture stderr; use sed to extract lines that are file paths
  set +e
  conflicts=$(config checkout 2>&1 || true \
    | sed -n 's/^[[:space:]]\+\(.*\)/\1/p')
  set -e

  # Move each conflict, creating parent dirs in backup
  while IFS= read -r file; do
    [ -z "$file" ] && continue
    src="$WORK_TREE/$file"
    dst="$BACKUP_DIR/$file"
    mkdir -p "$(dirname "$dst")"
    if [ -e "$src" ] || [ -L "$src" ]; then
      mv "$src" "$dst"
      echo "Moved: $src -> $dst"
    else
      echo "Warning: expected file $src not found; skipping"
    fi
  done <<< "$conflicts"

  # retry checkout (should succeed now)
  config checkout
  echo "Checked out dotfiles after moving conflicts."
fi

# keep git quiet about all other untracked files under $HOME
config config --local status.showUntrackedFiles no


# Adapted from https://mjones44.medium.com/storing-dotfiles-in-a-git-repository-53f765c0005d
# Now you can use the config alias to manage your dotfiles, e.g.:
# config status
# config add .vimrc
# config commit -m "Add vimrc"
# config push
