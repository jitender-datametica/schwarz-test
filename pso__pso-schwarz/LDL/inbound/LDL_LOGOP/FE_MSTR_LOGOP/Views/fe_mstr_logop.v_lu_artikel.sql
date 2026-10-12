/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_lu_artikel
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2025-05-23      Michal Kubica             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE Lookup Article View for Bestand EWM / LPV / WAWI
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LU_ARTIKEL(
    ARTICLE_NR COMMENT 'Article number. PK. Original name - ANR',
    ARTICLE_DESCRIPTION COMMENT 'Article name. Original name - KTXT',
    CLIENT_ID COMMENT 'Client ID as the Article IDs are not unique',
    WH_ID COMMENT 'Warehouse ID needed as a part of the key to determine single article'
) AS
SELECT DISTINCT(ARTICLE_NR), ARTICLE_DESCR, CLIENT_ID, WH_ID
FROM "DATA".T_LPV_AST
WHERE CURRENT_DATE BETWEEN DWH_VALID_FROM AND DWH_VALID_TO AND DELETED_FG = FALSE;
