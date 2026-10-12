/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_egritem
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM expected goods receipt item
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_sapewm_egritem AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_nr,
 ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
 doc_nr,
 item_nr,
 product_nr AS prod_nr,
 stock_type AS stk_type,
 quantity AS qty,
 uom,
 crtd_by,
 crtd_on_dt,
 crtd_at_tm,
 ref_code,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 is_active_fg
FROM ldl_logop_data.t_logop_sapewm_egritem;