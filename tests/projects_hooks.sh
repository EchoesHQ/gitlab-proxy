#!/usr/bin/env bash

# includes
. ./helpers.sh

setup_suite() {
    # create a test hook
    response=$(curl -sS --location -d '{"url":"http://foo.barr.com"}' --request POST "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/hooks" \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '"${PRIVATE_TOKEN}"'')

    hookID=$(echo "${response}" | jq -r '.id')
    export hookID
}

test_should_return_all_hooks() {
    # list hooks
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/hooks")

    # verify the hook is in the list
    doHave=$(has "${response}" "id" "${hookID}")
    assert_equals "${doHave}" true
}

test_should_disallow_hooks_GETbyID_POSTbyID() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/hooks/${hookID}")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"

    response=$(doRequest "POST" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/hooks/${hookID}")
    assert_equals 404 "$(echo "${response}" | jq -r '.status')"
}

teardown_suite() {
    # delete the test hook
    response=$(doRequest "DELETE" "${PROXY_BASE_PATH}/projects/${PROJECT_ID}/hooks/${hookID}")
}
