*** Settings ***
Documentation       This is to check unsuccessful login

Resource            ../../../keywords/ui/login.robot

Test Setup          Common Suite Setup
Test Teardown       Common Suite Teardown

*** Test Cases ***
Verify successfull login
    [Documentation]     This test is to verify successfull login attempt
    [Tags]    ui    login    negative
        Enter Username      ${invalid_user_email}

        #Assertion
        Verify Login Error     ${error_invalid_user}