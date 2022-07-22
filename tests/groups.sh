#!/usr/bin/env bash

# TODO: put this in env var output from the set_up_tests CI job
groupID=53719108

test_should_return_all_members() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/groups/'${groupID}'/members/all' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "2648022" "$(echo ${response} | jq -r '.[].id')"
}

test_should_return_members() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/groups/'${groupID}'/members' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "2648022" "$(echo ${response} | jq -r '.[].id')"
}

test_should_return_descendant_groups() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/groups/'${groupID}'/descendant_groups' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals 0 "$(echo ${response} | jq length)"
}

test_should_return_projects() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/groups/'${groupID}'/projects' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals 1 "$(echo ${response} | jq length)"
    assert_equals "36541542" "$(echo ${response} | jq -r '.[0].id')"
}

test_should_return_projects() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/groups/'${groupID}'/projects' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals 1 "$(echo ${response} | jq length)"
    assert_equals "36541542" "$(echo ${response} | jq -r '.[0].id')"
}

test_should_return_group() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/groups/'${groupID}'' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "${groupID}" "$(echo ${response} | jq -r '.id')"
}

test_should_return_groups() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/groups' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "12045471" "$(echo ${response} | jq -r '.[0].id')"
}
