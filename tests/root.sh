#!/usr/bin/env bash

# includes
. ./helpers.sh

test_should_return_status_ok() {
    response=$(doRequestI "GET" "${PROXY_BASE_PATH}/")
    assert_matches "HTTP/1.1 200 OK" "${response}"

    response=$(doRequestI "POST" "${PROXY_BASE_PATH}/")
    assert_matches "HTTP/1.1 200 OK" "${response}"

    response=$(doRequestI "PUT" "${PROXY_BASE_PATH}/")
    assert_matches "HTTP/1.1 200 OK" "${response}"

    response=$(doRequestI "DELETE" "${PROXY_BASE_PATH}/")
    assert_matches "HTTP/1.1 200 OK" "${response}"
}
