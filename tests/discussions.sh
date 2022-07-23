#!/usr/bin/env bash

# includes
. ./helpers.sh

mrID=3
discussionID=5c3abd25f4583bfdbf42d68f66d9097381f00fea

test_should_return_discussions() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}/discussions")
    assert_equals "${discussionID}" "$(echo "${response}" | jq -r '.[0].id')"
}

test_should_disallow_discussions_byID_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}/discussions/${discussionID}")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}/discussions/${discussionID}")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}/discussions/${discussionID}")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}
