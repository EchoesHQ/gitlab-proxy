#!/usr/bin/env bash

groupID=53719108

test_should_return_labels() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/groups/'${groupID}'/labels' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals 18 "$(echo ${response} | jq length)"
    assert_equals "25315376" "$(echo ${response} | jq -r '.[0].id')"
}
