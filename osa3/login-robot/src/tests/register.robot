*** Settings ***
Resource  resource.robot
Test Setup  Reset Database

*** Test Cases ***
Register With Valid Username And Password
    Register User  validuser  Valid123!
    Output Should Contain  User registered successfully

Register With Already Taken Username And Valid Password
    Register User  takenuser  Valid123!
    Output Should Contain  Username already taken

Register With Too Short Username And Valid Password
    Register User  us  Valid123!
    Output Should Contain  Invalid username

Register With Enough Long But Invalid Username And Valid Password
    Register User  invalid_user  Valid123!
    Output Should Contain  Invalid username

Register With Valid Username And Too Short Password
    Register User  validuser2  short1
    Output Should Contain  Invalid password

Register With Valid Username And Long Enough Password Containing Only Letters
    Register User  validuser3  onlyletters
    Output Should Contain  Invalid password

*** Keywords ***
Reset Database
    Clear Users

Register User
    [Arguments]  ${username}  ${password}
    Input Register Command  ${username}  ${password}
