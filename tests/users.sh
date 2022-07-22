#!/usr/bin/env bash

# TODO: put this in env var output from the set_up_tests CI job
userID=2648022

test_should_return_user_by_id() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/users/'${userID}'' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "2648022" "$(echo ${response} | jq -r '.id')"
}

test_should_return_current_user() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/user' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "2648022" "$(echo ${response} | jq -r '.id')"
}

test_should_return_all_users() {
    # on gitlab.com it is quite difficult to get a predictable result so
    # we check the default page length only i.e 20.
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/users' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals 20 "$(echo ${response} | jq length)"
}
