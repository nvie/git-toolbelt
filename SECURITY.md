# Security Policy

## Supported versions

git-toolbelt is a collection of standalone shell scripts. Only the latest
release receives fixes — there are no maintenance branches for older versions.
If you are on an older version, upgrade before reporting an issue.

## Reporting a vulnerability

Please **do not open a public issue** for security problems.

Report privately through GitHub's [private vulnerability reporting][gh-report]
(Security → Report a vulnerability on the repository).

Please include:

- which command(s) are affected, and which version you are on (`brew info nvie/tap/git-toolbelt`, or the commit SHA if you installed from source)
- your OS, shell, and Git version
- a minimal reproduction — the exact repository state and command line
- what an attacker gains from it

Since this is a spare-time project, please allow a reasonable window for a fix
before disclosing publicly.

## Scope

These tools run locally with the privileges of the user invoking them, on
repositories that user has chosen to work in. Things that are in scope:

- command or argument injection through branch names, tags, remote names, file
  paths, or other repository-controlled data that ends up in a shell command
- unquoted expansions that let attacker-controlled repository content escape
  into `eval`, subshells, or `git` invocations
- destructive behavior triggered on input that a user would reasonably consider
  safe (e.g. a command that discards work without asking, on a repository that
  merely has an unusual branch name)
- unsafe use of temporary files (predictable paths, symlink following)

Out of scope:

- commands doing exactly what they document, on repositories you cloned
  yourself. `git-drop-local-changes`, `git-trash`, `git-delouse` and friends
  discard work by design.
- running these scripts against a repository from an untrusted source. Cloning
  and operating on a hostile repository is dangerous with plain `git` too.
- vulnerabilities in Git, GNU coreutils, or your shell — report those upstream.

[gh-report]: https://github.com/nvie/git-toolbelt/security/advisories/new
