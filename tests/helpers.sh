#!/usr/bin/env bash

# In an array of objects, whether a property has the given value.
# [{ id: 1 }, { id: 2 }...]
# has $array "id" 2
function has() {
    array=$1
    prop=$2
    value=$3

    local isMatches
    for row in $(echo "${array}" | jq -r '.[] | @base64'); do
        _jq() {
            echo "${row}" | base64 --decode | jq -r "${1}"
        }

        found=$(_jq ".${prop}")

        if [ "${found}" = "${value}" ]; then
            isMatches=true

            echo "${isMatches}"
            return 0
        fi
    done

    isMatches=false

    echo "${isMatches}"
}

test_should_return_has_true() {
    array='[{"name":"foo"},{"name":"bar"}]'
    doHave=$(has "${array}" "name" "bar")
    assert_equals "${doHave}" true
}

test_should_return_has_false() {
    array='[{"name":"foo"},{"name":"bar"}]'
    doHave=$(has "${array}" "name" "baz")
    assert_equals "${doHave}" false
}


function doRequest() {
    url=$1
    method=$2

    response=$(curl -sS --location --request "${url}" "${method}" \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '"${PRIVATE_TOKEN}"'')

    echo "${response}"
}


function doRequestI() {
    url=$1
    method=$2

    response=$(curl -I --location --request "${url}" "${method}" \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '"${PRIVATE_TOKEN}"'' | grep "HTTP/1.1 200 OK")

    echo "${response}"
}
