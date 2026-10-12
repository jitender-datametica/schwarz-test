CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_agg_store_avg_vat_values_ejr (client_id, st_loc_sid, dat_formdate,
cy_month, orig_store_nr, wh_loc_sid, val_rtl_gross_ejr, val_rtl_net_ejr, avg_pct_vat_store,
avg_pct_vat_store_previous_day, avg_pct_vat_wh) AS SELECT client_id,
 st_loc_sid,
 dat_formdate,
 cy_month,
 orig_store_nr,
 wh_loc_sid,
 val_rtl_gross_ejr,
 val_rtl_net_ejr,
 avg_pct_vat_store,
 avg_pct_vat_store_previous_day,
 avg_pct_vat_wh
FROM ldl_p_lew_core.t_wawi_agg_store_avg_vat_values_ejr;