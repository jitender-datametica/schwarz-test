CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_agg_str_day_ejr_txj_ww_ext (client_id, store_id, dat_formdate, cy_month,
currency_iso_cd, val_retail_asis, val_retail_net_asis, cnt_customer_asis, val_retail_extrapol_asis,
val_retail_net_extrapol_asis) AS SELECT *
FROM ldl_p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_ext;