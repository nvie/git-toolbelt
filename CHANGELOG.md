# Next release

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
  * `git-assume`
  * `git-unassume`
  * `git-show-assumed`
  * `git-cleanup-squashed`

# v1.4.2

- Support `git-active-branches` on Windows (thanks @ernstki!)

# v1.4.1

- Added LICENSE

# v1.4.0

- New commands:
  * `git-skip`
  * `git-unskip`
  * `git-show-skipped`

- Deprecated commands:
  * `git-assume` (use `git-skip` now)
  * `git-unassume` (use `git-unskip` now)
  * `git-show-assumed` (use `git-show-skipped` now)
  * `git-cleanup-squashed` (use `git cleanup -s` now)

# v1.3.0

- New commands:
  * `git spinoff <new-branch> [<base>]` (inspired by Magit's spinoff command),
    will create a new branch from the current branch and will reset the current
    branch back to its upstream. Most useful when you have already committed
    work on master, but really wanted that to be a new local branch instead.
  * `git remote-tracking-branch [<branch>]` will print the name of the remote
    tracking branch of the current or given branch (if any)

# v1.2.4

- Added new utility `git-cleanup-squashed` which can detect and clean up
  branches that have been squashed-merged into master (thank you,
  @jonathanchu)!

# v1.2.3

- New script:
  * Add `git-branches-containing`, returning a list of branches containing the
    specified commit (thanks @RMGiroux!)

- Improvement:
  * Make `git-sha` work without further arguments (thanks @RMGiroux!)

# v1.2.2

- Bugfixes:
  * Make `git-fixup` not use `--no-verify` by default and instead respect
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
