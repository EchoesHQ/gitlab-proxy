#!/usr/bin/env bash

# includes
. ./helpers.sh

issueID=1

test_should_return_project_issues_resource_label_events() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/issues/${issueID}/resource_label_events")

    assert_equals 0 "$(echo "${response}" | jq length)"
}

test_should_disallow_projects_issues_resource_label_events_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/issues/${issueID}/resource_label_events")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/issues/${issueID}/resource_label_events")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/issues/${issueID}/resource_label_events")

    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}
