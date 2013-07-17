*** Settings ***
Documentation     Description de l'API
Suite Setup       Démarrer le serveur
Suite Teardown    Eteindre le serveur
Resource          ../strator.robot
Library           HttpLibrary.HTTP

*** Test Cases ***
Ping server
    [Documentation]    Le serveur doit répondre à l'adresse /ping
    ...    avec son état (OK) et la version de l'API (0.0.1)
    Create HTTP Context    ${SERVER_URL}    http
    Get    /ping
    Response Status Code Should Equal    200
    ${resp}=    Get Response Body
    Json Value Should Equal    ${resp}    /status    "OK"
    Json Value Should Equal    ${resp}    /version    "0.0.1"

Add a provider
    [Documentation]    Le serveur doit ajouter un fournisseur lors d'une
    ...    POST à l'adresse /providers
    Clear Database
    Create Http Context    ${SERVER_URL}    http
    Set Request Body    {"title":"AAAA"}
    Set Request Header    Content-Type    application/json
    Post    /providers
    Response Status Code Should Equal    201
    ${resp}=    Get Response Body
    Response Body Should Contain    "_id"
    Response Body Should Contain    "title"

Get providers list
    [Documentation]    Le serveur doit renvoyer une liste de fournisseurs
    ...    comprenant un titre et un identifiant, dans l'ordre
    ...    alphabétique.
    Clear Database
    Load Fixtures    providers
    Create HTTP Context    ${SERVER_URL}    http
    Get    /providers
    Response Status Code Should Equal    200
    ${resp}=    Get Response Body
    Json Value Should Equal    ${resp}    /0/title    "AAAA"
    Json Value Should Equal    ${resp}    /0/_id    "51e4a0f44b24cc020576516d"

Add a place
    [Documentation]    Le serveur doit ajouter un emplacement de rangement
    ...    lors d'un POST à l'adresse /places
    Clear Database
    Create HTTP Context    ${SERVER_URL}    http
    Set Request Body    {"place":"STORAGE"}
    Set Request Header    Content-Type    application/json
    Post    /places
    Response Status Code Should Equal    201
    ${resp}=    Get Response Body
    Response Body Should Contain    "_id"
    Response Body Should Contain    "place"

Get places list
    [Documentation]    Le serveur doit renvoyer la liste des emplacements
    ...    de rangement lors d'une requète GET à /places
    Clear Database
    Load Fixtures    places
    Create HTTP Context    ${SERVER_URL}    http
    Get    /places
    Response Status Code Should Equal    200
    ${resp}=    Get Response Body
    Json Value Should Equal    ${resp}    /0/place    "TEST0"
    Json Value Should Equal    ${resp}    /0/_id    "51e5c9c28ae47a4a56000002"

Add a security info
    [Documentation]    Le serveur doit créer une information de sécurité lors
    ...    d'une requète POST à l'adresse /security
    Clear Database
    Create HTTP Context    ${SERVER_URL}    http
    Set Request Body    {"type":"P","code":"ACID","details":"Corrosif"}
    Set Request Header    Content-Type    application/json
    Post    /security
    Response Status Code Should Equal    201
    ${resp}=    Get Response Body
    Response Body Should Contain    "_id"
    Response Body Should Contain    "type"
    Response Body Should Contain    "code"
    Response Body Should Contain    "details"

Get security list
    [Documentation]    Le serveur doit renvoyer une liste des éléments de sécurité
    ...    lors d'une requète GET à l'adresse /security
    Clear Database
    Load Fixtures    securities
    Create HTTP Context    ${SERVER_URL}    http
    Get    /security
    Response Status Code Should Equal    200
    ${resp}=    Get Response Body
    Json Value Should Equal    ${resp}    /0/type    "R"
    Json Value Should Equal    ${resp}    /0/_id    "52e5c9c28ae47a4a56000001"
    Json Value Should Equal    ${resp}    /0/code    "21"

Add an item
    [Documentation]    Le serveur doit créer un élément d'inventaire lors
    ...    d'une requète POST à l'adresse /items
    Clear Database
    Create HTTP Context    ${SERVER_URL}    http
    Set Request Body    {"title":"AAAA","code":"007","provider":["PROVIDER","51e4a0f44b24cc020576516d"], "place":["TEST0","51e5c9c28ae47a4a56000002"],"security":["52e5c9c28ae47a4a56000001","52e5c9c28ae47a4a56000002"]}
    Set Request Header    Content-Type    application/json
    Post    /items
    Response Status Code Should Equal    201
    ${resp}=    Get Response Body
    Response Body Should Contain    "_id"
    Response Body Should Contain    "title"
    Response Body Should Contain    "code"
    Response Body Should Contain    "provider"

Get items list
    [Documentation]    Le serveur doit renvoyer une liste des éléments d'inventaire
    ...    lors d'une requète GET à l'adresse /items
    Clear Database
    Load Fixtures    items
    Create HTTP Context    ${SERVER_URL}    http
    Get    /items
    Response Status Code Should Equal    200
    ${resp}=    Get Response Body
    Json Value Should Equal    ${resp}    /0/title    "AAAA"
    Json Value Should Equal    ${resp}    /0/code    "007"
