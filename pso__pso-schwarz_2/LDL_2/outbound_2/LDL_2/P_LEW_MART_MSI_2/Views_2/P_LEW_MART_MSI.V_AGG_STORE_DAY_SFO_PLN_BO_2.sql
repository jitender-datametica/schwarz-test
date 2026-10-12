CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_store_day_sfo_pln_bo_2 AS SELECT st_loc_sid AS store_id,
 client_id,
 dat_formdate,
 cy_month,
 sfotype_id,
 orig_store_nr,
 qty_total_sfo,
 qty_total_sfo_wrtoff_zero,
 val_rtl_rl_sfo,
 val_rtl_rl_net_sfo,
 val_wrtoff_zero,
 val_wrtoff_zero_net
FROM ldl_p_lew_core_ac.v_wawi_agg_store_day_sfo_2 AS A;