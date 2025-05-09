# Unreleased

# v1.9.4

- Refactor scripts to improve safety and reliability:
  - Add proper quoting around variables and command substitutions
  - Use `read -r` for safer input handling in while loops
  - Replace `-n` tests with explicit empty string comparisons
  - Fix command formatting in documentation
  - Improve URL formatting in documentation

# v1.9.3

- Fix: use main branch in `git-merged` (instead of hardcoding `master`)

# v1.9.2

- `git-shatter-by-file` will still work when there are "skipped" files
- Various internal shell script improvements

# v1.9.1

- `git-main-branch` will now also recognize `mainline` as a main branch name,
  for users migrating from Perforce.
- `git-shatter-by-file` will still work when there are "skipped" files
- Various internal shell script improvements

# v1.9.0

- git-cleave will now prefix commit messages (instead of suffix them) wth the
  path matches it cleaves off
- git-cleave now takes a `-t <prefix>` flag, which will be used instead of the
  path matches
- git-cleave will now prevent empty commits from being destroyed

# v1.8.4

- Fix issue where the probe for "(g)realpath" can fail

# v1.8.3

- Hide possible warnings displayed by `which` on some platforms

# v1.8.2

- Fix the fix from 1.8.1, which broke some Linux distros.

# v1.8.1

- Fix to be compatible with `coreutils` 9.2+, which renamed `realpath` → `grealpath`

# v1.8.0

- New command: `git-diff-since`
- New command: `git-sync-commit-date`
- `git-cleanup` will now only remove branches after explicit `-l` (local) or `-r` (remote) flag

# v1.7.1

- Add `-m` option to `git-modified` to only show locally modified files
- Fix: make `git-merges-cleanly` work when there are skipped files

# v1.7.0

- New command: `git-cleave` to split a commit by file paths.

# v1.6.0

- New command: `git-wip`. This will create quick save point
  commits for Work In Progress (WIP). This creates quick commits
  without writing a commit message.

- `git-initial-commit` will now report the more user-friendly error "No commits
  yet" for an empty repo (#46, thanks @Shea690901 and @ernstki!)

- `git active-branches` now supports a `-s <date>` option (for `--since`),
  where you can specify the threshold for what is considered "active" (#36,
  thanks @ernstki!)

# v1.5.1

- Fixes an issue where `git-local-branches` could report "HEAD detached at ..."
  message (#44, thanks @asford!)

# v1.5.0

- Add support for repos with a default branch named main (not master)
- Adds a new script git main-branch
- Drop deprecated scripts:
  - `git-assume`
  - `git-unassume`
  - `git-show-assumed`
  - `git-cleanup-squashed`

# v1.4.2

- Support `git-active-branches` on Windows (thanks @ernstki!)

# v1.4.1

- Added LICENSE

# v1.4.0

- New commands:

  - `git-skip`
  - `git-unskip`
  - `git-show-skipped`

- Deprecated commands:
  - `git-assume` (use `git-skip` now)
  - `git-unassume` (use `git-unskip` now)
  - `git-show-assumed` (use `git-show-skipped` now)
  - `git-cleanup-squashed` (use `git cleanup -s` now)

# v1.3.0

- New commands:
  - `git spinoff <new-branch> [<base>]` (inspired by Magit's spinoff command),
    will create a new branch from the current branch and will reset the current
    branch back to its upstream. Most useful when you have already committed
    work on master, but really wanted that to be a new local branch instead.
  - `git remote-tracking-branch [<branch>]` will print the name of the remote
    tracking branch of the current or given branch (if any)

# v1.2.4

- Added new utility `git-cleanup-squashed` which can detect and clean up
  branches that have been squashed-merged into master (thank you,
  @jonathanchu)!

# v1.2.3

- New script:

  - Add `git-branches-containing`, returning a list of branches containing the
    specified commit (thanks @RMGiroux!)

- Improvement:
  - Make `git-sha` work without further arguments (thanks @RMGiroux!)

# v1.2.2

- Bugfixes:
  - Make `git-fixup` not use `--no-verify` by default and instead respect
    existing pre-commit hooks

# v1.2.1

- Fix: don't verify when fixing up
- Fix: autostash when rebasing interactively after fixups
- Fix: docs for `git-workon`

# v1.2.0

- New command: `git-fixup-with`
- Fixes some bugs in `git-shatter-by-file` that happened when not called from
  the git root

# v1.1.5

- Add `git-separator`
- Add `git-shatter-by-file`

# v1.1.4 and older

No changelog kept here yet.
