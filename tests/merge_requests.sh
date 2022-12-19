#!/usr/bin/env bash

# includes
. ./helpers.sh

mrID=3

test_should_return_merge_requests() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/merge_requests")

    doHave=$(has "${response}" "iid" "${mrID}")
    assert_equals "${doHave}" true
}

test_should_return_paginated_merge_requests() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/merge_requests?page=2&per_page=2")
    assert_equals 2 "$(echo "${response}" | jq length)"
}

test_should_disallow_merge_requests_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/merge_requests")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/merge_requests")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/merge_requests")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}

test_should_return_closes_issues() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}/closes_issues")

    assert_equals 1 "$(echo "${response}" | jq length)"
}

test_should_return_commits() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}/commits")

    assert_equals 1 "$(echo "${response}" | jq length)"
    assert_equals "8ee68e7a27ccfe18460ab3d78c6fba7ced3b465c" "$(echo "${response}" | jq -r '.[0].id')"
}

test_should_disallow_groups_merge_requests_commits_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/merge_requests/${mrID}/commits")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/merge_requests/${mrID}/commits")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/merge_requests/${mrID}/commits")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}

test_should_return_project_merge_request_by_id() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}")
    assert_equals "${mrID}" "$(echo "${response}" | jq -r '.iid')"

    # Test project access via an URL-encoded path
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/projects/echoes-hq%2Fgitlab-proxy-test/merge_requests/${mrID}")
    assert_equals "${mrID}" "$(echo "${response}" | jq -r '.iid')"

    # Test project access via a non URL-encoded path returns a 404 (from GitLab)
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/projects/echoes-hq/gitlab-proxy-test/merge_requests/${mrID}")
    assert_equals "404 Not Found" "$(echo "${response}" | jq -r '.error')"
}

test_should_disallow_project_merge_requests_byID_POST_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}

test_should_return_project_merge_requests() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests")

    assert_equals 6 "$(echo "${response}" | jq length)"

    doHave=$(has "${response}" "iid" "${mrID}")
    assert_equals "${doHave}" true
}

test_should_disallow_projects_merge_requests_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}

test_should_return_project_merge_requests_resource_label_events() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}/resource_label_events")

    assert_equals 0 "$(echo "${response}" | jq length)"
}

test_should_disallow_projects_merge_requests_resource_label_events_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}/resource_label_events")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}/resource_label_events")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/merge_requests/${mrID}/resource_label_events")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}
