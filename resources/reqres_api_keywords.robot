*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary

*** Variables ***
${BASE_URL}       https://reqres.in/api

*** Keywords ***
Create API Session
    Create Session    reqres    ${BASE_URL}

Delete API Session
    Delete All Sessions

User sends a GET request to single users endpoint
    ${response}=    GET On Session    reqres    /users/2
    Set Test Variable    ${response}

Get response status code should be 200
    ${Status_Code}=  convert to string  ${response.status_code}
    should be equal  ${Status_Code}  200

Get response should contain valid data
    ${json_response}=  Set Variable  ${response.json()}
    Should Be Equal As Strings  ${json_response["data"]["id"]}  2
    Should Be Equal As Strings  ${json_response["data"]["first_name"]}  Janet
    Should Be Equal As Strings  ${json_response["data"]["last_name"]}  Weaver

When User sends a POST request to "${endpoint}" with data "${data}"
    ${json_data}=    Evaluate    json.loads('''${data}''')    json
    ${response}=    POST On Session    reqres    ${endpoint}    json=${json_data}
    Set Test Variable    ${response}

Post response status code should be 201
    ${Status_Code}=  convert to string  ${response.status_code}
    should be equal  ${Status_Code}  201

Post response should contain valid data
    ${json_response}=  Set Variable  ${response.json()}
    Should Be Equal As Strings  ${json_response["name"]}  John
    Should Be Equal As Strings  ${json_response["job"]}  leader
