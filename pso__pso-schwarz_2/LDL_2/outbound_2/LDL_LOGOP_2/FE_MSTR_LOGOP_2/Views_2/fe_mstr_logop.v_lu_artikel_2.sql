/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_lu_artikel_2
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


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_artikel_2 (article_nr
OPTIONS(description='Article number. PK. Original name - ANR'), article_description
OPTIONS(description='Article name. Original name - KTXT'), client_id
OPTIONS(description='Client ID as the Article IDs are not unique'), wh_id
OPTIONS(description='Warehouse ID needed as a part of the key to determine single article')) AS SELECT DISTINCT
 article_nr,
 article_descr AS article_description,
 client_id,
 wh_id
FROM ldl_logop_data.t_lpv_ast_2
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND NOT deleted_fg;