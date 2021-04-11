*** Settings ***

Resource       common.robot
Variables      ../../locators/ui/login.py
Variables      ../../variables/login.py

*** Keywords ***

Enter Username
    [Arguments]     ${username}
        Wait Until Element is Visible   ${txt_username}
        Wait Until Element is Enabled   ${txt_username}
        Input Text      ${txt_username}     ${username}
        Wait Until Element is Enabled   ${btn_next}
        Click Element     ${btn_next}

Enter Password
    [Arguments]     ${password}
        Wait Until Element is Visible   ${txt_password}
        Wait Until Element is Enabled   ${txt_password}
        Input Password      ${txt_password}     ${password}
        Wait Until Element is Enabled   ${btn_next}
        Click Element     ${btn_next}

Verify Successful Login
        ${lbl_user_profile}=     Catenate    //div[text()='${VALID_USER_FIRSTNAME}']
        Wait Until Element is Enabled   ${lbl_user_profile}
        Wait Until Element is Visible   ${lbl_user_profile}

Verify Login Error
    [Arguments]     ${expected_error}
        Wait Until Element is Visible   ${lbl_error_invalid_user}
        ${error}=   Get Text    ${lbl_error_invalid_user}
        Should be equal as strings     ${error}    ${expected_error}