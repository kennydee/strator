*** Settings ***
Documentation     Description de l'API
Resource          ../strator.robot
Library           HttpLibrary.HTTP
Suite Setup       Démarrer le serveur
Suite Teardown    Eteindre le serveur

*** Test Cases ***
Ping server
    [Documentation]   Le serveur doit répondre à l'adresse /ping
    ...               avec son état (OK) et la version de l'API (0.0.1)
    Create HTTP Context    ${SERVER_URL}    http
    Get   /ping
    Response Status Code Should Equal   200
    ${resp}=    Get Response Body
    Json Value Should Equal    ${resp}   /status    "OK"
    Json Value Should Equal    ${resp}   /version   "0.0.1"


Add a provider
    [Documentation]   Le serveur doit ajouter un fournisseur lors d'une
    ...               POST à l'adresse /providers
    Create Http Context    ${SERVER_URL}    http
    Set Request Body       {"title":"AAAA"}
    Post                   /providers
    Response Status Code Should Equal    201
    ${resp}=   Get Response Body
    Response Body Should Contain    "_id"

Get providers list
    [Documentation]   Le serveur doit renvoyer une liste de fournisseurs
    ...               comprenant un titre et un identifiant, dans l'ordre
    ...               alphabétique.
    Clear Database
    Load Fixtures               providers
    Create HTTP Context    ${SERVER_URL}    http
    Get   /providers
    Response Status Code Should Equal   200
    ${resp}=    Get Response Body
    Json Value Should Equal    ${resp}   /0/title    "AAAA"
    Json Value Should Equal    ${resp}   /0/_id      "51e4a0f44b24cc020576516d"

