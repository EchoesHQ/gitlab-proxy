#!/usr/bin/env bash

# includes
. ./helpers.sh

name="Test gitlab-proxy "

test_should_return_token_description() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/personal_access_tokens/self")
    assert_equals "${name}" "$(echo "${response}" | jq -r '.name')"
}

test_should_disallow_token_description_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/personal_access_tokens/self")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/personal_access_tokens/self")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/personal_access_tokens/self")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}
