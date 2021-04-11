*** Settings ***
Documentation       This is to check successful login

Resource            ../../../keywords/ui/login.robot
Test Setup          Common Suite Setup
Test Teardown       Common Suite Teardown

*** Test Cases ***
Verify successfull login
    [Documentation]     This test is to verify successfull login attempt
    [Tags]    ui    login   critical    positive
        Enter Username      ${VALID_USER_EMAIL}
        Enter Password      ${VALID_PASSWORD}

        #Assertion
        Verify Successful Login