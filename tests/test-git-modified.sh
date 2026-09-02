#!/bin/sh
set -e

if [ -z "$REPO_ROOT" ]; then
  echo "REPO_ROOT must be set to repository root to find git-modified" >&2
  exit 2
fi

TMPDIR=$(mktemp -d)
cd "$TMPDIR"

# initialize a new repo to test git-modified behavior
git init -q
printf 'hello' > a.txt
git add a.txt
git commit -q -m "add a"

COMMIT=$(git rev-parse --verify --quiet HEAD)

# Run git-modified from the repo under test
OUT=$("$REPO_ROOT/git-modified" "$COMMIT")

if [ "$OUT" = "a.txt" ]; then
  echo "ok: git-modified produced expected output"
  exit 0
else
  echo "fail: git-modified output was: '$OUT'" >&2
  exit 1
fi
