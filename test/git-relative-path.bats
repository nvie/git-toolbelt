load helpers

@test "prefixes names starting with - or + with ./" {
    init_repo

    run git relative-path -rf +42 normal.txt

    [ "$status" -eq 0 ]
    assert_output - <<EOF
./-rf
./+42
normal.txt
EOF
}

@test "prefixes ./ relative to the current directory" {
    init_repo
    mkdir src
    cd src

    run git relative-path -rf +42 src/-x

    [ "$status" -eq 0 ]
    assert_output - <<EOF
../-rf
../+42
./-x
EOF
}
