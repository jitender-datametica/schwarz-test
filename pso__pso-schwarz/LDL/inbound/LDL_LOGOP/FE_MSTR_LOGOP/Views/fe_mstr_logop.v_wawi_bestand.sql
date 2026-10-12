/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_wawi_bestand
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2025-05-23      Michal Kubica           Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    View for WAWI Bestand report
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_WAWI_BESTAND(
	CLIENT_ID COMMENT 'Client id - calculated based on the country code',
	WH_ID COMMENT 'Warehouse ID',
	DATE COMMENT 'Date',
	ARTICLE_NR COMMENT 'Article',
	MENGE COMMENT 'Menge',
	INHALT_KARTON COMMENT 'The content of the carton',
	KARTON_EURO COMMENT 'Karton Euro'
) AS
SELECT A.CLIENT_ID, A.WH_NR, A.DATUM, A.ARTIKELNR,A.MENGE - A.MOVING_STOCK AS MENGE, B.INHALT_KARTON, B.KARTON_EURO
FROM "DATA".T_WAWI_BESTANDARTIKEL A
LEFT JOIN "DATA".T_WAWI_ARTIKEL B
ON A.CLIENT_ID = B.CLIENT_ID
AND A.ARTIKELNR = B.ARTIKELNR
WHERE CURRENT_DATE BETWEEN A.DWH_VALID_FROM AND A.DWH_VALID_TO
AND A.DELETED_FG = FALSE
AND CURRENT_DATE BETWEEN B.DWH_VALID_FROM AND B.DWH_VALID_TO
AND B.DELETED_FG = FALSE
AND CURRENT_DATE - 1 = TO_DATE(A.DATUM); 

