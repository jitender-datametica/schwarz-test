CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_TICKETS_COUNTRY_2(
	 COUNTRY_TICKET_ID
	,COUNTRY_NAME
	,COUNTRY_FLAG_IMG
	,COUNTRY_FLAG_IMG_NAME
	,OPENED_BY_GROUP
) AS 
SELECT DISTINCT 
    country_ticket_id
    ,CASE
        WHEN CONTAINS(country_ticket_id, 'MT') THEN 'Malta'
        WHEN CONTAINS(country_ticket_id, 'ES') THEN 'Spanien'
        WHEN CONTAINS(country_ticket_id, 'IT') THEN 'Italien'
        WHEN CONTAINS(country_ticket_id, 'DE') AND CONTAINS(opened_by_group,'int') THEN 'Stiftung inkl. Schwarz IT'
        WHEN CONTAINS(country_ticket_id, 'DE') AND NOT CONTAINS(opened_by_group,'int') THEN 'Deutschland'
        WHEN CONTAINS(country_ticket_id, 'CY') THEN 'Zypern'
        WHEN CONTAINS(country_ticket_id, 'NI') THEN 'Nordirland'
        WHEN CONTAINS(country_ticket_id, 'GR') THEN 'Griechenland'
        WHEN CONTAINS(country_ticket_id, 'DK') THEN 'Daenemark'
        WHEN CONTAINS(country_ticket_id, 'BE') THEN 'Belgien'
        WHEN CONTAINS(country_ticket_id, 'PT') THEN 'Portugal'
        WHEN CONTAINS(country_ticket_id, 'FI') THEN 'Finnland'
        WHEN CONTAINS(country_ticket_id, 'GB') THEN 'Grossbritannien'
        WHEN CONTAINS(country_ticket_id, 'CZ') THEN 'Tschechien'
        WHEN CONTAINS(country_ticket_id, 'HR') THEN 'Kroatien'
        WHEN CONTAINS(country_ticket_id, 'CH') THEN 'Schweiz'
        WHEN CONTAINS(country_ticket_id, 'SI') THEN 'Slowenien'
        WHEN CONTAINS(country_ticket_id, 'FR') THEN 'Frankreich'
        WHEN CONTAINS(country_ticket_id, 'HU') THEN 'Ungarn'
        WHEN CONTAINS(country_ticket_id, 'AT') THEN 'Oesterreich'
        WHEN CONTAINS(country_ticket_id, 'PL') AND CONTAINS(opened_by_group,'ldl-int') THEN 'Stiftung inkl. Schwarz IT'
        WHEN CONTAINS(country_ticket_id, 'PL') AND NOT CONTAINS(opened_by_group,'ldl-int') THEN 'Polen'
        WHEN CONTAINS(country_ticket_id, 'BG') THEN 'Bulgarien'
        WHEN CONTAINS(country_ticket_id, 'CS') THEN 'Kanarische-Inseln'
        WHEN CONTAINS(country_ticket_id, 'US') THEN 'USA'
        WHEN CONTAINS(country_ticket_id, 'SE') THEN 'Schweden'
        WHEN CONTAINS(country_ticket_id, 'SK') THEN 'Slowakei'
        WHEN CONTAINS(country_ticket_id, 'RS_2') THEN 'Serbien'
        WHEN CONTAINS(country_ticket_id, 'RO') THEN 'Rumaenien'
        WHEN CONTAINS(country_ticket_id, 'IE') THEN 'Irland'
        WHEN CONTAINS(country_ticket_id, 'NL') THEN 'Niederlande'
        WHEN CONTAINS(country_ticket_id, 'LT') THEN 'Litauen'
        WHEN CONTAINS(country_ticket_id, 'LV') THEN 'Lettland'
        WHEN country_ticket_id LIKE ANY ('S','S-HQ') THEN 'Stiftung inkl. Schwarz IT'
        WHEN CONTAINS(country_ticket_id, 'EE') THEN 'Estland'
    END AS country_name
    ,CASE WHEN country_name = 'Stiftung inkl. Schwarz IT' THEN
        '<img src="../images/lidl/BCBI/Länderflaggen/schwarz_logo.jpg"
        style="width:25px"/>'
     ELSE
       CONCAT(
        '<img src="../images/lidl/BCBI/Länderflaggen/Flaggen_RGB_'
        ,country_name
        ,'.png" style="width:25px"/>'
        ) 
    END AS country_flag_img
    ,CASE WHEN country_name = 'Stiftung inkl. Schwarz IT' THEN
        CONCAT(
            '<span>'
            ,'<img src="../images/lidl/BCBI/Länderflaggen/schwarz_logo.jpg"
            style="width:25px;margin-right:15px;padding-top:5px"/> Stiftung inkl. Schwarz IT
            </span>'
        )
        ELSE
        CONCAT(
            '<span>'
            ,'<img src="../images/lidl/BCBI/Länderflaggen/Flaggen_RGB_'
            ,country_name
            ,'.png" style="width:25px;margin-right:15px;padding-top:5px"/>'
            ,country_name
            ,'</span>'
        ) 
    END AS country_flag_img_name
    ,opened_by_group
FROM FE_MSTR_BCBI.V_TICKETS_DAILY_2;