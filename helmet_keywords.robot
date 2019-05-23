*** Settings ***
Library             Collections

*** Keywords ***
Initialize Browser
    Open Browser        ${helmet_url}    gc

Choose English Fantasy Category
    Click On Category    Englanninkielinen fantasia- ja tieteiskirjallisuus

Click On Category
    [Arguments]         ${text}
    Click Element       link:${text}

Get Books For Every Location
    FOR     ${location}    IN   @{DATA}
            Open Random Book Page
            Scrape Book Data    ${location}
            # Note the exploitation of 'pass by object reference'
            # https://robertheaton.com/2014/02/09/pythons-pass-by-object-reference-as-explained-by-philip-k-dick/
            Go Back
    END

Open Random Book Page
    ${n_books}=             Get Element Count   xpath://div[@class="rssChannelEntry"]
    ${n}=    Evaluate       random.randint(1, ${n_books})   modules=random
    Click Element           xpath://div[@class="rssChannelEntry"][${n}]/span/a

Scrape Book Data
    [Arguments]             ${location}
    ${title}=    Get Title
    ${author}=   Get Author
    ${year}=     Get Year Published
    Initialize Book Dictionary    ${location}
    Set To Dictionary    ${location["book"]}    title=${title}
    Set To Dictionary    ${location["book"]}    author=${author}
    Set To Dictionary    ${location["book"]}    year=${year}

Initialize Book Dictionary
    [Arguments]          ${location}
    ${book}=     Create Dictionary
    Set To Dictionary    ${location}    book=${book}

Get Title
    ${title}=    Get Text    id:bibTitle
    [Return]        ${title}

Get Author
    ${author}=    Get Text    id:authorDisplayLinkComponent
    [Return]        ${author}

Get Year Published
    ${year}=    Get Text    id:searchResultPubYearInsertComponent
    [Return]        ${year}
