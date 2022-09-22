#!/usr/bin/env bash

# includes
. ./helpers.sh

test_should_return_labels() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/labels")

    doHave=$(has "${response}" "id" "26133076")
    assert_equals "${doHave}" true

    # There are more than 20 labels on the group.
    # Since no pagination was specified, it returns the default page size i.e 20.
    assert_equals 20 "$(echo "${response}" | jq length)"
}

test_should_return_paginated_labels() {
    # page 1
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/labels?page=1&per_page=5")
    assert_equals 5 "$(echo "${response}" | jq length)"

    # page 2
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/labels?page=2&per_page=5")
    assert_equals 5 "$(echo "${response}" | jq length)"
}
