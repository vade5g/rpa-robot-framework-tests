*** Settings ***
Variables           ../resources/settings.py
Library             SeleniumLibrary
Library             ../libraries/CSVReader.py
Library             ../libraries/JSONLibrary.py
Resource            ../resources/helmet_keywords.robot
Suite Teardown      Close All Browsers

*** Tasks ***
Read Input Data
    [Tags]                  stage_0
    ${data}=                Read CSV File   ${input_file}
    Set Suite Variable      ${DATA}         ${data}


Scrape Data From Helmet
    [Tags]                  stage_1
    Initialize Browser
    Choose English Fantasy Category
    Get Books For Every Location

Last Stage
    [Tags]                  stage_2
    Save JSON file to disk
