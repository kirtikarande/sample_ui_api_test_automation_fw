*** Settings ***

Documentation       This is to test get api call to list the posts of a user.

Resource            ../../../keywords/api/posts.robot

Suite Setup         Common Suite Setup
Suite Teardown      Common Suite Teardown

Force Tags          api    posts   critical    positive

*** Test Cases ***

Verify Get Call for Extracting All User Post Details
    [Documentation]     This is to verify the get call to get details of all user posts is working as expected.
        ${resp}=    Get User Post Details
        Validate Elements of JSON response     ${resp}      posts/get_userpost_all.json

Verify Get Call for Extracting User Post Details by ID
    [Documentation]      This is to verify the get call to get details of a particular user post by post's id is working as expected.
        ${resp}=    Get User Post Details      ${valid_post_id}
        Validate JSON response     ${resp}      posts/get_userpost_all.json
