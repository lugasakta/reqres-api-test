*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource         ../resources/reqres_api_keywords.robot

Test Setup        Create API Session
Test Teardown     Delete API Session

*** Test Cases ***
Get Details of a Single User
   Given User sends a GET request to single users endpoint
   Then Get response status code should be 200
   And Get response should contain valid data

Create a New User
   When User sends a POST request to "/users" with data "{"name": "John", "job": "leader"}"
   Then Post response status code should be 201
   And Post response should contain valid data