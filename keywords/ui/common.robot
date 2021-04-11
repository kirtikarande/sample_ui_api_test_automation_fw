*** Settings ***

Library       BuiltIn
Library       ../../lib/custom_selenium_library.py

Variables     ../../locators/ui/common.py
Variables     ../../variables/common.py
Variables     ../../variables/env/environment.py
Variables     ../../variables/env/${ENV}_variables.py

*** Keyword ***

Start Chrome Browser
    [Documentation]    Starts a chrome browser to be stimualted on xvfb.
        ${options}=    Evaluate   sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
        Call Method  ${options}  add_argument  --no-sandbox
        Call Method  ${options}  add_argument  --start-maximized
        Call Method  ${options}  add_argument  ignore-certificate-errors
        Create Webdriver  Chrome  chrome_options=${options}

Start Firefox Browser
    [Documentation]  starts a firefox browser to be stimualted on xvfb
        ${profile}=    evaluate   sys.modules['selenium.webdriver'].FirefoxProfile()   sys, selenium.webdriver
        ${caps}=  Evaluate  sys.modules['selenium.webdriver'].common.desired_capabilities.DesiredCapabilities.FIREFOX  sys
        Set To Dictionary  ${caps}  CapabilityType.UNEXPECTED_ALERT_BEHAVIOUR=UnexpectedAlertBehaviour.ACCEPT
        #call method  ${profile}  add_argument  --start-maximized
        create webdriver  Firefox  firefox_profile=${profile}

Common Suite Setup
    [Documentation]    This runs before Suite Execution starts.
        Set Selenium Timeout    120s
        Open URL    ${BASE_URL}     ${BROWSER}

Common Suite Teardown
    [Documentation]    This runs after the Suite execution completes.
        Close All Browsers

Open URL
    [Arguments]     ${url}      ${browser}
        Log     Browser=${browser}
        Run Keyword     Start ${browser} Browser
        Go To   ${url}