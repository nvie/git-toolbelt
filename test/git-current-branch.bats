bats_require_minimum_version 1.5.0

load helpers

@test "prints the name of the current branch" {
    init_repo
    git checkout -q -b feature/foo

    run git current-branch

    [ "$status" -eq 0 ]
    assert_output "feature/foo"
}

@test "fails with an error on a detached HEAD" {
    init_repo
    git checkout -q --detach

    run --separate-stderr git current-branch

    [ "$status" -eq 1 ]
    assert_output ""
    [ "$stderr" = "Not on a branch." ]
}

@test "prints branch names with unusual characters as-is" {
    init_repo
    git checkout -q -b "it's-\$weird\"#ü%!"

    run git current-branch

    [ "$status" -eq 0 ]
    assert_output "it's-\$weird\"#ü%!"
}

@test "prints a branch name that looks like a commit SHA" {
    init_repo
    git checkout -q -b "$(git rev-parse --short HEAD)"
    expected="$(git rev-parse --short HEAD)"

    run git current-branch

    [ "$status" -eq 0 ]
    assert_output "$expected"
}

@test "works from a subdirectory" {
    init_repo
    mkdir -p a/b
    cd a/b

    run git current-branch

    [ "$status" -eq 0 ]
    assert_output "main"
}

@test "works from inside the .git directory" {
    init_repo
    cd .git

    run git current-branch

    [ "$status" -eq 0 ]
    assert_output "main"
}

@test "prints the branch of the linked worktree it runs in" {
    mkdir repo
    cd repo
    init_repo
    git worktree add -q -b other ../wt
    cd ../wt

    run git current-branch

    [ "$status" -eq 0 ]
    assert_output "other"
}

@test "fails with an error while a rebase is stopped" {
    init_repo
    git commit -q --allow-empty -m "Second commit"
    GIT_SEQUENCE_EDITOR="sed -i.bak s/^pick/edit/" git rebase -q -i HEAD~1

    run --separate-stderr git current-branch

    [ "$status" -eq 1 ]
    assert_output ""
    [ "$stderr" = "Not on a branch." ]
}

@test "fails outside of a Git repo" {
    run git current-branch

    [ "$status" -ne 0 ]
}

@test "prints the local name of a branch that tracks a remote branch" {
    mkdir upstream
    (cd upstream && init_repo && git branch feature)
    git clone -q upstream clone
    cd clone
    git checkout -q feature

    run git current-branch

    [ "$status" -eq 0 ]
    assert_output "feature"
}

@test "fails with an error after checking out a remote-tracking branch" {
    mkdir upstream
    (cd upstream && init_repo)
    git clone -q upstream clone
    cd clone
    git checkout -q origin/main

    run --separate-stderr git current-branch

    [ "$status" -eq 1 ]
    assert_output ""
    [ "$stderr" = "Not on a branch." ]
}

@test "prints a branch named refs/heads/foo as-is" {
    init_repo
    git checkout -q -b refs/heads/foo

    run git current-branch

    [ "$status" -eq 0 ]
    assert_output "refs/heads/foo"
}

@test "prints a branch named heads/foo as-is" {
    init_repo
    git checkout -q -b heads/foo

    run git current-branch

    [ "$status" -eq 0 ]
    assert_output "heads/foo"
}

@test "prints a branch named tags/foo as-is" {
    init_repo
    git checkout -q -b tags/foo

    run git current-branch

    [ "$status" -eq 0 ]
    assert_output "tags/foo"
}

@test "prints a branch named remotes/origin/main as-is" {
    init_repo
    git checkout -q -b remotes/origin/main

    run git current-branch

    [ "$status" -eq 0 ]
    assert_output "remotes/origin/main"
}
