load helpers

@test "tests start in an empty directory" {
    run ls -A

    [ "$status" -eq 0 ]
    assert_output ""
}
