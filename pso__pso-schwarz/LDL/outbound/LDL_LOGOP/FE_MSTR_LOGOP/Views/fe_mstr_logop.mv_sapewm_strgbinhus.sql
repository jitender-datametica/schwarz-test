/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_strgbinhus
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM storage bin handling units
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_logop_fe_mstr_logop.mv_sapewm_strgbinhus AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_nr,
 ROUND(CAST(LTRIM(REGEXP_EXTRACT(wh_nr, '\\d+'), '0') AS NUMERIC), 0) AS wh_id,
 hu_ident,
 activity_area AS act_area,
 sub_activity_area AS sub_act_area,
 hu_type,
 zz_hu_type,
 crtd_by,
 crtd_on_dt,
 crtd_at_tm,
 changed_on_dt AS chg_on_dt,
 changed_at_tm AS chg_at_tm,
 hu_weight,
 weight_unit,
 capa,
 vol_unit,
 sale_flg,
 category AS cat,
 open_hu_wt_flg,
 pack_mat,
 strg_bin,
 sorted_non_food_flg,
 pair_bracket,
 sys_pal,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_logop_sapewm_storagebinhus;