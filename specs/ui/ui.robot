*** Settings ***
Documentation     Description de l'interface utilisateur
Resource          ../strator.robot

*** Test cases ***
Page d'accueil
    [Documentation]    La page d'accueil doit répondre à l'adresse index.html
    ...    Elle doit présenter un titre, un formulaire d'inscription,
    ...    un formulaire de login, et des explications
    Ouvrir le navigateur
    Wait Until Page Contains    Strator


Inscription
    [Documentation]    Deux types d'inscription : rejoindre un groupe déjà constitué
    ...                ou bien créer un nouveau laboratoire
    Fail               Test not ready    not-ready
*** Keywords ***
Ouvrir le navigateur
    Open Browser    http://${CLIENT_URL}/index.html    browser=firefox
