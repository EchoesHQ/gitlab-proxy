#!/usr/bin/env bash

# includes
. ./helpers.sh

test_should_return_all_members() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/members/all")

    length=$(echo "${response}" | jq length)

    success=false
    if [ "${length}" -gt 0 ]; then
        success=true
    fi

    assert "${success}" || fail 'all groups members should be found'
}

test_should_return_members() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/members")

    length=$(echo "${response}" | jq length)

    success=false
    if [ "${length}" -gt 0 ]; then
        success=true
    fi

    assert "${success}" || fail 'groups members should be found'
}

test_should_disallow_members_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/members/all")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/members/all")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/members/all")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}

test_should_return_descendant_groups() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/descendant_groups")
    assert_equals 0 "$(echo "${response}" | jq length)"
}

test_should_disallow_descendant_groups_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/descendant_groups")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/descendant_groups")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/descendant_groups")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}

test_should_return_projects() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/projects")

    doHave=$(has "${response}" "name" "GitLab-Proxy-Test")
    assert_equals "${doHave}" true
}

test_should_disallow_projects_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/projects")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/projects")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/projects")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}

test_should_return_group() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/groups/${GROUP_ID}")
    assert_equals "${GROUP_ID}" "$(echo "${response}" | jq -r '.id')"
}

test_should_disallow_group_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/groups/${GROUP_ID}")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/groups/${GROUP_ID}")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/groups/${GROUP_ID}")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}

test_should_return_groups() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/groups")

    doHave=$(has "${response}" "name" "EchoesHQ")
    assert_equals "${doHave}" true
}

test_should_disallow_groups_POST_PUT_DELETE() {
    response=$(doRequest "POST" "${PROXY_BASE_PATH}/groups")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "PUT" "${PROXY_BASE_PATH}/groups")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/groups")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}
