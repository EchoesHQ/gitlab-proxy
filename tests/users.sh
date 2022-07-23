#!/usr/bin/env bash

# includes
. ./helpers.sh

userID=8876968

test_should_return_user_by_id() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/users/${userID}")
    assert_equals "${userID}" "$(echo "${response}" | jq -r '.id')"
}

test_should_disallow_user_byID_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/users/${userID}")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/users/${userID}")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/users/${userID}")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}

test_should_return_current_user() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/user")
    assert_equals "${userID}" "$(echo "${response}" | jq -r '.id')"
}

test_should_disallow_current_user_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/user")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/user")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/user")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}

test_should_return_all_users() {
    # on gitlab.com it is quite difficult to get a predictable result so
    # we check the default page length only i.e 20.
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/users")
    assert_equals 20 "$(echo "${response}" | jq length)"
}

test_should_disallow_all_users_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/users")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/users")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/users")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}
