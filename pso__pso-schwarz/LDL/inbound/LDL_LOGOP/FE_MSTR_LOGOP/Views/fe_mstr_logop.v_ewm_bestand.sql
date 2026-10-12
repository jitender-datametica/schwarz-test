/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_ewm_bestand
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2025-05-23      Michal Kubica           Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    View for EWM Bestand report
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_EWM_BESTAND(
	CLIENT_ID COMMENT 'Client id - calculated based on the country code',
	WH_ID COMMENT 'Warehouse ID',
	STORAGE_TYPE COMMENT 'Storage Type',
	ARTICLE_NR COMMENT 'Product ID',
	ARTICLE_DESCRIPTION COMMENT 'Product Short Description',
	QUAN COMMENT 'Quantity',
	UNIT COMMENT 'Base Unit of Measure',
	INHALT_KARTON COMMENT 'The content of the carton',
	KARTON_EURO COMMENT 'Karton Euro',
	QUAN_CASES COMMENT 'Quantity Cases',
	DWH_UPDATED COMMENT 'Latest update time'
) AS
WITH EWM_BESTAND AS
(SELECT A.CLIENT_ID, A.WH_ID, A.LGTYP, A.MATNR, A.MAKTX, A.QUAN, A.UNIT, B.INHALT_KARTON, B.KARTON_EURO, A.DWH_UPDATED
FROM "DATA".T_SAPEWM_PHYSICALSTOCK A
LEFT JOIN "DATA".T_WAWI_ARTIKEL B
ON A.CLIENT_ID = B.CLIENT_ID 
AND A.MATNR = B.ARTIKELNR
WHERE CURRENT_DATE BETWEEN A.DWH_VALID_FROM AND A.DWH_VALID_TO
AND A.DELETED_FG = FALSE)
SELECT 
CLIENT_ID
,WH_ID
,LGTYP
,MATNR
,MAKTX
,QUAN
,UNIT
,INHALT_KARTON
,KARTON_EURO
,CASE WHEN UNIT = 'PC' THEN QUAN / INHALT_KARTON ELSE NULL END AS QUAN_CASES
,MAX(DWH_UPDATED) OVER (PARTITION BY CLIENT_ID, WH_ID) AS DWH_UPDATED
FROM EWM_BESTAND;