*** Settings ***

Resource            common.robot

Variables           ../../variables/posts.py

*** Keywords ***

Get User Post Details
    [Documentation]     This keyword is to place the Get call for posts
    [Arguments]     ${post_id}=${EMPTY}
        ${response}=    Place Request for API      GET    /posts/${post_id}
    [Return]    ${response}
