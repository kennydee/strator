*** Settings ***
Documentation   Strator specs suite
Library         OperatingSystem
Library         Process
Library         Selenium2Library    WITH NAME    selenium
Library         HttpLibrary
Library         ./libs/utils.py

*** Variables ***
${SERVER_URL}    localhost:3000   # Server url
${CLIENT_URL}    localhost:9000   # Client url
${SERVER_PATH}   ${CURDIR}/../server
${CLIENT_PATH}   ${CURDIR}/../client
${NODE}          node



*** Keywords ***
    Installer le client
    Installer le serveur
    Lancer le client
    Lancer le serveur

Installer le client
    ChangeDirectory    ${CLIENT_PATH}
    Run                npm install
    Run                grunt

Installer le serveur
    ChangeDirectory    ${SERVER_PATH}
    Run                npm install
    Run                grunt

Lancer le serveur
    Start Process      ${NODE}     app.js   cwd=${SERVER_PATH}    alias=server
    Sleep              5s

Lancer le client
    Run Process      grunt      build   cwd=${CLIENT_PATH}
    Start Process      grunt      connect:dist:keepalive   cwd=${CLIENT_PATH}    alias=client
    Sleep              5s

Démarrer le serveur
    Installer le serveur
    Lancer le serveur

Démarrer le client
    Installer le client
    Lancer le client

Eteindre le serveur
    [Documentation]    Tue le process group du serveur
    ...                Utilise des fonctionnalités probablement "linux only"
    ${SERVER_PID}=     Get Process Id    server
    Run Process        kill ${SERVER_PID}    shell=True
    Sleep              2s

Eteindre le client
    [Documentation]    Utilise des fonctionnalités à mon avis très "linuxiennes"
    ...                Utilise des fonctionnalités probablement "linux only"
    ${CLIENT_PID}=     Get Process Id    client
    Run Process        kill ${CLIENT_PID}    shell=True
    Sleep              2s

Démarrer client et serveur
    Démarrer le serveur
    Démarrer le client

Eteindre client et serveur
    Eteindre le client
    Eteindre le serveur

Clear Database
    Run Process        mongo strator --eval "db.dropDatabase();"    shell=True

Load fixtures
    [Documentation]   Charge des données dans la base
    [Arguments]       @{fixtures}
    :FOR   ${fixture}   IN   @{fixtures}
    \      ${import}=   Run Process   mongoimport --db strator --collection ${fixture} --jsonArray --file ${CURDIR}/fixtures/${fixture}.json    shell=True
    \      Log          ${import.stdout}
    \      Log          ${import.stderr}