/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_strgbinfixbinasg
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM storage bin fix bin assignment
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_sapewm_strgbinfixbinasg AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_nr,
 ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
 strg_bin,
 strg_bin_assgn_type_flg,
 product_nr AS prod_nr,
 product_desc AS prod_desc,
 product_assgn_type AS prod_asgmt_type,
 party_entitled_dispose,
 stock_in_fix_bin_flg,
 is_strg_bin_imprvbl,
 strg_bin_imprvbl_change_dt AS strg_bin_imprvbl_chg_dt,
 strg_type,
 strg_sec,
 strg_bin_empty_flg,
 crtd_by,
 crtd_on_dt,
 crtd_at_tm,
 ps_area,
 campaign_flg,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_logop_sapewm_storagebinfixbinasg;