#!/usr/bin/env bash

# includes
. ./helpers.sh

test_should_return_labels() {
    response=$(doRequest "GET" "${PROXY_BASE_PATH}/groups/${GROUP_ID}/labels")

    doHave=$(has "${response}" "id" "26133076")
    assert_equals "${doHave}" true
}
