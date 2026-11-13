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

# Puts a `realpath` and `grealpath` first on PATH that print the given
# version string, and otherwise behave like the real GNU realpath
stub_realpath_version () {
    gnu_realpath="$(command -v grealpath || command -v realpath)"
    mkdir -p "$BATS_TEST_TMPDIR/bin"
    for name in realpath grealpath; do
        cat > "$BATS_TEST_TMPDIR/bin/$name" <<STUB
#!/bin/sh
if [ "\$1" = --version ]; then echo "$1"; exit 0; fi
exec "$gnu_realpath" "\$@"
STUB
        chmod +x "$BATS_TEST_TMPDIR/bin/$name"
    done
    PATH="$BATS_TEST_TMPDIR/bin:$PATH"
}

@test "works with a non-GNU realpath that supports --relative-to" {
    stub_realpath_version "realpath (uutils coreutils) 0.12.0"
    init_repo
    mkdir src
    cd src

    run git relative-path foo.txt

    [ "$status" -eq 0 ]
    assert_output "../foo.txt"
}

@test "refuses a realpath that doesn't support --relative-to" {
    mkdir bin
    for name in realpath grealpath; do
        printf '#!/bin/sh\necho "realpath: illegal option -- -" >&2\nexit 1\n' > "bin/$name"
        chmod +x "bin/$name"
    done
    PATH="$PWD/bin:$PATH"
    init_repo

    run git relative-path foo.txt

    [ "$status" -eq 1 ]
    assert_output "No 'realpath' that supports --relative-to found (tried grealpath, realpath). Please install GNU coreutils."
}
