#!/usr/bin/env bash

# TODO: put this in env var output from the set_up_tests CI job
projectID=36541542
mrID=13

test_should_return_discussions() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/projects/'${projectID}'/merge_requests/'${mrID}'/discussions' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "a1c36c2f5f1ce4b62a7dd7f6f94f6ccf0deb5ff4" "$(echo ${response} | jq -r '.[0].id')"
}
