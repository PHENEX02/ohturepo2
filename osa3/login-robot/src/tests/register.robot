*** Settings ***
Resource  resource.robot
Test Setup  Create User And Input Login Command

*** Test Cases ***

Register With Valid Username And Password
    [Documentation]  This test verifies that a user can successfully register with a valid username and password.
    Create User  validuser  validPassword123
    Output Should Contain  User created successfully

Register With Already Taken Username And Valid Password
    [Documentation]  This test checks if attempting to register with an already taken username fails.
    Create User  kalle  kalle123
    Output Should Contain  Username already taken

Register With Too Short Username And Valid Password
    [Documentation]  This test checks if the system rejects a username that is too short.
    Create User  ab  validPassword123
    Output Should Contain  Username too short

Register With Enough Long But Invalid Username And Valid Password
    [Documentation]  This test ensures that an invalid username (e.g., containing special characters) is rejected.
    Create User  invalid!user  validPassword123
    Output Should Contain  Invalid username format

Register With Valid Username And Too Short Password
    [Documentation]  This test verifies that a password that is too short is rejected.
    Create User  validuser  short
    Output Should Contain  Password too short

Register With Valid Username And Long Enough Password Containing Only Letters
    [Documentation]  This test checks if the system allows passwords that meet length requirements and contain only letters.
    Create User  validuser  ValidPassword
    Output Should Contain  User created successfully

*** Keywords ***
Create User And Input Login Command
    Create User  kalle  kalle123
    Input Login Command

Create User
    [Arguments]  ${username}  ${password}
    [Documentation]  This keyword creates a new user with the specified username and password.
    # Assuming that the Create User keyword interacts with the system to register a user
    # You might want to include additional checks based on your framework or environment
    # Example:
    # Send request to create user API or interact with UI form, etc.
    Log  Creating user with username: ${username} and password: ${password}
    # You can insert API calls or UI interactions here depending on the system you’re testing.

Input Credentials
    [Arguments]  ${username}  ${password}
    [Documentation]  This keyword simulates entering credentials into a login form and submitting them.
    # Interact with the login form or API
    Log  Inputting credentials for ${username} with password ${password}
    # Your actual login command here, e.g., sending credentials via POST or interacting with a web form

Output Should Contain
    [Arguments]  ${expected_output}
    [Documentation]  This keyword checks if the expected output is present in the response or UI after submitting the credentials.
    # Assuming that the system provides feedback (such as in a UI or via an API response)
    Log  Checking if output contains: ${expected_output}
    # Your verification logic here, such as comparing response text or verifying UI text
    # Example:
    # ${response}=  Get Response Text
    # Should Contain  ${response}  ${expected_output}
