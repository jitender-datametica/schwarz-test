/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_strgbin_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM storage bin
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_sapewm_strgbin_1 AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_nr,
 ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
 strg_bin,
 strg_type,
 strg_sec,
 strg_bin_type,
 bin_acs_type,
 hu_cnt,
 strg_bin_max_weight,
 vol_unit,
 strg_bin_mat_weight,
 is_strg_bin_empty_flg,
 is_strg_bin_full_flg,
 first_ptwy_dt,
 last_mov_tm,
 last_mov_dt,
 cnt_dt,
 pi_doc_nr,
 strg_bin_aisle,
 strg_bin_stack,
 strg_bin_level,
 bin_sec,
 losc_grp,
 bin_depth,
 rec_strg_grp,
 rem_bin_depth,
 max_bin_depth,
 field_load_grp,
 max_nr_of_hu,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_logop_sapewm_storagebin_1;