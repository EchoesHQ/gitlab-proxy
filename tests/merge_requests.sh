#!/usr/bin/env bash

# TODO: put this in env var output from the set_up_tests CI job
groupID=53719108
projectID=36541542
mrID=13

test_should_return_merge_requests() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/groups/'${groupID}'/merge_requests' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "36541542" "$(echo ${response} | jq -r '.[0].id')"
}

test_should_return_closes_issues() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/projects/'${projectID}'/merge_requests/'${mrID}'/closes_issues' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "109451069" "$(echo ${response} | jq -r '.[0].id')"
}

test_should_return_commits() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/projects/'${projectID}'/merge_requests/'${mrID}'/commits' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "5fe70de8936babbcfb10ee36c505356fe207df8a" "$(echo ${response} | jq -r '.[0].id')"
}

test_should_return_project_merge_request_by_id() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/projects/'${projectID}'/merge_requests/'${mrID}'' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "158333519" "$(echo ${response} | jq -r '.id')"
}

test_should_return_project_merge_requests() {
    response=$(curl -sS --location --request GET 'http://0.0.0.0:8080/api/v4/projects/'${projectID}'/merge_requests' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: '${PRIVATE_TOKEN}'')

    assert_equals "158333519" "$(echo ${response} | jq -r '.[0].id')"
}
