load helpers

@test "prints names starting with - or + as ./-name and ./+name" {
    init_repo
    touch -- -rf +42 normal.txt

    run git modified

    [ "$status" -eq 0 ]
    assert_output - <<EOF
./+42
./-rf
normal.txt
EOF
}

@test "prefixes ./ relative to the current directory" {
    init_repo
    mkdir src
    touch -- -rf src/-x src/+y
    git add -A
    cd src

    run git modified -i

    [ "$status" -eq 0 ]
    assert_output - <<EOF
../-rf
./+y
./-x
EOF
}
