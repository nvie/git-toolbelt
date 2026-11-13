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

@test "prints names with spaces, quotes and backslashes as-is" {
    init_repo
    touch -- ' lead.txt' 'with space.txt' 'quo"te.txt' 'back\tab.txt' 'a -> b.txt'

    run git modified

    [ "$status" -eq 0 ]
    assert_output - <<'EOF'
 lead.txt
a -> b.txt
back\tab.txt
quo"te.txt
with space.txt
EOF
}

@test "prints only the new name of a renamed file" {
    init_repo
    echo hi > 'old name.txt'
    git add -A
    git commit -q -m "Add file"
    git mv 'old name.txt' 'new name.txt'

    run git modified -i

    [ "$status" -eq 0 ]
    assert_output "new name.txt"
}

@test "prints names with spaces, quotes and backslashes as-is for a commit" {
    init_repo
    touch -- ' lead.txt' 'with space.txt' 'quo"te.txt' 'back\tab.txt'
    git add -A
    git commit -q -m "Add files"

    run git modified HEAD

    [ "$status" -eq 0 ]
    assert_output - <<'EOF'
 lead.txt
back\tab.txt
quo"te.txt
with space.txt
EOF
}
