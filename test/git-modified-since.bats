load helpers

@test "prints names starting with - or + as ./-name and ./+name" {
    init_repo
    git switch -q -c feature
    touch -- -rf +42 normal.txt
    git add -A
    git commit -q -m "Add files"

    run git modified-since

    [ "$status" -eq 0 ]
    assert_output - <<EOF
./+42
./-rf
normal.txt
EOF
}

@test "prints names with spaces, quotes and backslashes as-is" {
    init_repo
    git switch -q -c feature
    touch -- ' lead.txt' 'with space.txt' 'quo"te.txt' 'back\tab.txt'
    git add -A
    git commit -q -m "Add files"

    run git modified-since

    [ "$status" -eq 0 ]
    assert_output - <<'EOF'
 lead.txt
back\tab.txt
quo"te.txt
with space.txt
EOF
}
