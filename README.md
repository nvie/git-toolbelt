# git-tools

Helper tools to make everyday life with Git much easier.


### git current-branch

Returns the name of the current branch, if any.  Why doesn't this come with git?

Alias to `git rev-parse --abbrev-ref HEAD`.


### git push-current

Pushed the current branch out to `origin`, and makes sure to setup tracking of
the remote branch.  Shorthand for `git push -u origin <current-branch>`.

Accepts options, too, so you can use

    $ git push-current -f

to force-push.


### git is-merged-into

Tests if X is merged into Y:

    $ git is-merged-into X Y


### git aa

Mimics the index / staging area to match the working tree exactly.  Adds files,
removes files, etc.

Alias to `git add --all`.


### git cc

Unstages everything.  Leaves the working tree intact.

Alias to `git reset HEAD`.


### git cleanup

Deletes all local and remote branches that have already been merged into master
or develop (or any other branch you consider a long-running branch). Keeps
other branches lying around.

Considers and respects the remote branch states, too. Will be most conservative
with deletions.


### git fixup

Amend all local staged changes into the last commit. Ideal for fixing typo's,
when you don't want to re-edit the commit message.

    $ git commit -m "Something cool."
    $ vim somefile.txt  # fix typo
    $ git add somefile.txt
    $ git fixup  # merge this little change back into the last commit


### git workon

Convenience command for quickly switching to a branch <name>. If such local
branch does not exist, but there is a remote branch named origin/<name>, then
a local branch is created and the remote is tracked. If the local branch
already exists, it's git pull --rebase'ed to update to the latest remote state.


### git delouse

Say you want to rebuild your last commit, but want to keep the commit message.
git delouse empties the last commit on the current branch and places all
changes back into the working tree.

Since the commit remains in history, you can now rebuild the commit by "git
amend"'ing or "git fixup"'ing, instead of making new commits.


### git commit-to

Every been on a branch and really wanted to quickly commit a change to
a different branch?  Given that this is possible without merge conflicts, git
commit-to will allow you to do so, without checking out the branch necessarily.

    $ git branch 
      master
    * mybranch
    $ git status
    M foo.txt
    M bar.txt
    $ git add foo.txt
    $ git commit-to master -m "Add foo to master."
    $ git add bar.txt
    $ git commit -m "Add bar to mybranch."


### git cherry-pick-to

Every been on a branch, just made a commit, but really want that commit
available on other branches as well? You can now cherry-pick this commit to any
branch, staying on the current branch. (Given the change won't lead to a merge
conflict.)

    $ git branch
      master
    * mybranch
    $ git add foo.txt
    $ git commit -m "Really useful thing."
    $ git cherry-pick-to master HEAD
    $ git branch  # did not switch branches
      master
    * mybranch


### git has-local-changes

Helper function that determines whether there are local changes in the working
tree, by returning a 0 (local changes) or 1 (no local changes) exit code.


### git drop-local-changes

Don't care about your local working copy's state and really want to revert back
to whatever is recorded in the history? git drop-local-changes lets you do
this.

This covers aborting rebases, undoing partial merges, resetting the index and
removing any unknown local files from the work tree. Anything that is already
committed remains safe.

??? issue a git pull, too? Typical beginners will want this.


### git force-checkout

Don't care about your local working copy's state and really want to switch to
another branch? git force-checkout lets you do this.

Switching branches can be prevented by git. For good reasons, mostly. Git is
designed to prevent you from losing data potentially. Examples are there are
local unmerged files, or some files that would be overwritten by doing the
checkout.

By using force-checkout you basically give git the finger, and check out
a branch anyway. **You do agree to lose data when using this command.**

    $ git checkout master
    error: Your local changes to the following files would be overwritten by checkout:
        foo/bar.txt
    Please, commit your changes or stash them before you can switch branches.
    Aborting
    $ git force-checkout master
    Switched to branch 'master'


### git conflicts

Generates a summary for all (specified) branches that will merged
uncleanly—i.e. will have merge conflicts later on.

    $ git branch
      develop
    * mybranch
      master
      other-branch
    $ git conflicts -a
    mybranch <-> develop: ok
    mybranch <-> master: ok
    mybranch <-> other-branch: CONFLICTS
