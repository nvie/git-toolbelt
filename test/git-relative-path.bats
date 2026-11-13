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

# Puts `realpath` and `grealpath` stubs first on PATH, both running the given
# script. The script can delegate to the real one via $real_realpath.
stub_realpath () {
    real_realpath="$(command -v grealpath || command -v realpath)"
    mkdir -p "$BATS_TEST_TMPDIR/bin"
    for name in realpath grealpath; do
        printf "#!/bin/sh\nreal_realpath='%s'\n%s\n" "$real_realpath" "$1" > "$BATS_TEST_TMPDIR/bin/$name"
        chmod +x "$BATS_TEST_TMPDIR/bin/$name"
    done
    PATH="$BATS_TEST_TMPDIR/bin:$PATH"
}

@test "works with a non-GNU realpath that supports --relative-to" {
    stub_realpath '
        if [ "$1" = --version ]; then echo "realpath (uutils coreutils) 0.12.0"; exit 0; fi
        exec "$real_realpath" "$@"
    '
    init_repo
    mkdir src
    cd src

    run git relative-path foo.txt

    [ "$status" -eq 0 ]
    assert_output "../foo.txt"
}

@test "refuses a realpath that doesn't support --relative-to" {
    stub_realpath '
        echo "realpath: illegal option -- -" >&2
        exit 1
    '
    init_repo

    run git relative-path foo.txt

    [ "$status" -eq 1 ]
    assert_output "No 'realpath' that supports --relative-to found (tried grealpath, realpath). Please install GNU coreutils."
}
