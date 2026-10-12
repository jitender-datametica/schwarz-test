CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_agg_wh_day_sell_prclc_2 (client_id, client_desc, country_group_id,
country_group_desc, gl_region_id, gl_region_desc, wh_id, wh_desc, aspect_id, aspect_desc, currency_iso_cd, curr_tot_id,
dat_formdate, val_adj_gross_sfo_store, val_adj_gross_sfo_store_py, val_adj_net_sfo_store, val_adj_net_sfo_store_py,
val_rtl_gro_wt_hrs_net, val_rtl_gro_wt_hrs_net_py, val_rtl_net_wt_hrs_net, val_rtl_net_wt_hrs_net_py,
val_retail_gross_asis, val_retail_gross_asis_py, val_retail_net_asis, val_retail_net_asis_py) AS SELECT *
FROM ldl_p_lew_mart_msi.v_agg_wh_day_sell_prclc_2;