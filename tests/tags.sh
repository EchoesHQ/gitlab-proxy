#!/usr/bin/env bash

# TODO: put this in env var output from the set_up_tests CI job
projectID=36541542

test_should_return_tags() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/projects/'${projectID}'/repository/tags' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals 0 "$(echo ${response} | jq length)"
}
