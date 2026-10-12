CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_agg_wh_wk_nf_alter_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
-- WH Auflösung
 SELECT AGG.cy_week_partial_week_id,
 AGG.cy_week_partial_week_id2,
 AGG.client_id,
 WH.src_wh_id AS wh_id,
 AGG.currency_iso_cd,
 AGG.byr,
 AGG.month_id,
 AGG.week_id,
 AGG.cur_stock_wh,
 AGG.pwd_stock_wh,
 AGG.nf_alter_wh_wk_asis,
 AGG.nf_alter_wh_wk_pyd,
 AGG.nf_alter_wh_mth_asis,
 AGG.nf_alter_wh_mth_pyd,
 AGG.nf_alter_wh_py_asis,
 AGG.nf_alter_wh_py_pyd
FROM ldl_p_lew_mart_msi.t_agg_wh_wk_nf_alter_2 AS AGG
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON AGG.client_id = WH.client_id AND AGG.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1;