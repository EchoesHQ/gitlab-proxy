#!/usr/bin/env bash

# includes
. ./helpers.sh

test_should_return_tags() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/repository/tags")
    assert_equals 1 "$(echo "${response}" | jq length)"
    assert_equals "0.1.0" "$(echo "${response}" | jq -r '.[0].name')"
}

test_should_disallow_tags_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/repository/tags")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/repository/tags")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/repository/tags")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}
