/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_phyinvdoc_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM pyhsical inventory document
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_sapewm_phyinvdoc_2 AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_nr,
 ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
 doc_nr,
 item_nr,
 doc_year,
 doc_type,
 doc_status,
 activity_area AS act_area,
 reason,
 reason_desc,
 prio,
 prio_desc,
 crtd_on_dt,
 crtd_at_tm,
 crtd_by,
 activ_dt AS act_dt,
 activ_tm AS act_tm,
 cnt_dt,
 cnt_tm,
 cnt_user,
 post_dt,
 post_tm,
 last_changed_by,
 strg_bin_empty,
 strg_type,
 strg_sec,
 strg_bin,
 product_nr AS prod_nr,
 product_desc AS prod_desc,
 batch,
 stock_type AS stk_type,
 stock_type_desc AS stk_type_desc,
 party_entitled_dispose,
 partner_role_party_entitled_dispose,
 gr_dt,
 ui_gr_dt,
 ui_gr_tm,
 shelf_life_exp_dt,
 who_nr,
 quan_book AS qty_book,
 quan_count AS qty_count,
 quan_diff AS qty_diff,
 quan_diff_abs AS qty_diff_abs,
 buom,
 value_diff,
 value_diff_abs,
 curr_key,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_logop_data.t_logop_sapewm_pidocument_2;