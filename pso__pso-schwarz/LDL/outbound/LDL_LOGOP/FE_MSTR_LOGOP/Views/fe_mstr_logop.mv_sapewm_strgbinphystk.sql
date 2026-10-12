/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_strgbinphystk
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM storage bin physical stock
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_sapewm_strgbinphystk AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_nr,
 ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
 log_pos,
 hu_ident,
 product_nr AS prod_nr,
 product_desc AS prod_desc,
 quantity AS qty,
 buom,
 packed_qnty_auom,
 stock_type,
 batch,
 shelf_life_exp_date,
 gr_dt,
 gr_tm,
 doc_cat_doc_ref,
 doc_nr,
 strg_bin,
 auom,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_logop_sapewm_storagebinphystk;