# Shared setup for all tests. Every test file starts with `load helpers`.

setup () {
    if [ -z "${GIT_TOOLBELT_SANDBOX-}" ]; then
        echo "Not sandboxed: run tests with 'make test', never with bats directly." >&2
        return 1
    fi

    # Every test starts in its own empty directory
    cd "$BATS_TEST_TMPDIR"
}

# Asserts that the output of the last `run` is exactly the expected text,
# given as an argument, or on stdin with `-`/`--stdin`:
#
#     assert_output "hello"
#     assert_output - <<EOF
#     hello
#     EOF
#
# Inspired by bats-assert's assert_output, of which this is a compatible
# subset (literal matching only), so switching to bats-assert later is a
# drop-in replacement.
assert_output () {
    if [ $# -ne 1 ]; then
        echo "usage: assert_output <expected> | assert_output -" >&2
        return 2
    fi
    case "$1" in
        -|--stdin) expected="$(cat)";;
        *) expected="$1";;
    esac
    if [ "$output" != "$expected" ]; then
        printf 'expected:\n%s\nactual:\n%s\n' "$expected" "$output" >&2
        return 1
    fi
}
