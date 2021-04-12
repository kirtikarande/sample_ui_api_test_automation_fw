*** Settings ***

Library         Collections
Library         RequestsLibrary
Library         JSONLibrary
Library         ../../lib/custom_library.py

Variables       ../../variables/env/environment.py
Variables       ../../variables/env/${ENV}_variables.py

*** Keyword ***

Common Suite Setup
    [Documentation]     This keyword contains the setup required for all the tests in a testsuite to run.
        Create Session    SESSION_A    ${API_HOST}

Common Suite Teardown
    [Documentation]     This keyword contains the teardown required for all the tests in a testsuite after the execution completes.
        Delete All Sessions

Place Request for API
    [Documentation]     This Keyword places the required request.
    [Arguments]         ${request_method}   ${api_endpoint}     ${expected_status}=200      ${params}=${EMPTY}      ${headers}=${EMPTY}     ${data}=${EMPTY}
        ${resp_json}=     Run Keyword     ${request_method} On Session     SESSION_A    ${api_endpoint}       expected_status=${expected_status}    params=${params}    headers=${headers}     data=${data}
    [Return]    ${resp_json}

Validate Elements of JSON response
    [Documentation]     This keyword is to verify that the json format of the element of the array response matches the expected regex pattern.
    [Arguments]         ${actual_response}   ${expected_response}
        # Get Actual Response body
        ${json_actual}=     Set Variable  ${actual_response.json()}

        # Get Expected Response
        ${path_resp_file}=    Catenate     ${CURDIR}${/}..${/}..${/}responses${/}${expected_response}
        ${json_expected}=   Load JSON From File       ${path_resp_file}

        Log To Console     actual:\n${json_actual}\nexpected:\n${json_expected}
        # Validate Element With Regex     ${json_actual}      ${json_expected}
        FOR    ${item}    IN    @{json_actual}
            Validate JSON Responses     ${item}     ${json_expected}
        END

Validate JSON Response
    [Documentation]     This keyword is to verify that the json format of the response matches the expected regex pattern.
    [Arguments]         ${actual_response}   ${expected_response}
        # Get Actual Response body
        ${json_actual}=     Set Variable  ${actual_response.json()}

        # Get Expected Response
        ${path_resp_file}=    Catenate     ${CURDIR}${/}..${/}..${/}responses${/}${expected_response}
        ${json_expected}=   Load JSON From File       ${path_resp_file}

        #Log To Console     actual:\n${json_actual}\nexpected:\n${json_expected}
        Validate JSON Responses     ${json_actual}     ${json_expected}
