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
