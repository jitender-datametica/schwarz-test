CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_MAINTENANCE_INCIDENTS_2 AS 
SELECT 
    ID
    ,INFO_TYPE
    ,SUBJECT
    ,CURRENT_STATUS
    ,AFFECTED_COUNTRIES
    ,DATE(AFFECTED_DAY) AS AFFECTED_DAY
    ,CREATED_ON
    ,CHANGED_ON
    ,CONCAT(
        'https://schwarzit.sharepoint.com/teams/Spielwiese/Lists/Strungs%20und%20Wartungsinformationen/DispForm.aspx?ID='
        ,ID
    ) AS URL
    ,CONCAT(
        '<a href="'
        ,URL
        ,'" target="_blank" >'
        ,'Cosmic Link'
        ,'</a>'
    ) AS LINK_HTML
FROM FE_MSTR_BCBI.T_MAINTENANCE_INCIDENTS_2;