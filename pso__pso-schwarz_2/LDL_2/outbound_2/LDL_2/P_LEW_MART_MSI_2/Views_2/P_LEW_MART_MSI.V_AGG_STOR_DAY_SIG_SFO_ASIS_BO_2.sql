CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_stor_day_sig_sfo_asis_bo_2 (store_id, client_id, subitemgroup_id,
dat_formdate, cy_month, sfotype_id, pcwo_reason_id, orig_store_nr, qty_total_sfo_asis, qty_total_sfo_wrtoff_zero_asis,
val_rtl_rl_sfo_asis, val_rtl_rl_net_sfo_asis, val_wrtoff_zero_asis, val_wrtoff_zero_net_asis) AS SELECT st_loc_sid AS
 store_id,
 client_id,
 subitemgroup_id,
 dat_formdate,
 cy_month,
 sfotype_id,
 pcwo_reason_id,
 orig_store_nr,
 qty_total_sfo_asis,
 qty_total_sfo_wrtoff_zero_asis,
 val_rtl_rl_sfo_asis,
 val_rtl_rl_net_sfo_asis,
 val_wrtoff_zero_asis,
 val_wrtoff_zero_net_asis
FROM ldl_p_lew_core_ac.v_wawi_agg_store_day_sig_sfo_asis_2;