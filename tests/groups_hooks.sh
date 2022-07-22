#!/usr/bin/env bash

# TODO: put this in env var output from the set_up_tests CI job
groupID=53719108
hookID=12852818

test_should_return_all_hooks() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/groups/'${groupID}'/hooks' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals ${hookID} "$(echo ${response} | jq -r '.[0].id')"
}

test_should_return_hooks_by_id() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/groups/'${groupID}'/hooks/'${hookID}'' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "404" "$(echo ${response} | jq -r '.status')"
}
