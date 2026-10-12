/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_egrhdr
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM expected goods receipt header
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_sapewm_egrhdr AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_nr,
 ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
 doc_nr,
 blocked_status AS blocked_stat,
 doc_type,
 doc_type_desc,
 ship_from_nr,
 planned_dlv_dt AS plnd_dlv_dt,
 planned_dlv_tm AS plnd_dlv_tm,
 crtd_on_dt,
 crtd_at_tm,
 crtd_by,
 lia_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 is_active_fg
FROM ldl_logop_data.t_logop_sapewm_egrheader;