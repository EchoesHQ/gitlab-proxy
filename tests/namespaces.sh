#!/usr/bin/env bash

# includes
. ./helpers.sh

test_should_return_namespaces() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/namespaces")

    doHave=$(has "${response}" "id" "12045471")
    assert_equals "${doHave}" true
}

test_should_return_paginated_namespaces() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/namespaces?page=1&per_page=2")
    assert_equals 2 "$(echo "${response}" | jq length)"
}

test_should_disallow_namespaces_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/namespaces")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/namespaces")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/namespaces")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}
