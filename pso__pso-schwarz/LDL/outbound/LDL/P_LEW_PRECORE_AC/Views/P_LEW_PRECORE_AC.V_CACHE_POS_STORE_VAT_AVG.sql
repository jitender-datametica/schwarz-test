CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_pos_store_vat_avg (client_id, loc_sid_store, dwh_cal_dt, loc_sid_wh
, sales_val, sales_net_val, avg_pct_vat_store, avg_pct_vat_store_prvs_shadow, avg_pct_vat_wh, dwh_load_id, dwh_created,
dwh_updated) AS SELECT client_id,
 loc_sid_store,
 dwh_cal_dt,
 loc_sid_wh,
 sales_val,
 sales_net_val,
 avg_pct_vat_store,
 avg_pct_vat_store_prvs_shadow,
 avg_pct_vat_wh,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_pos_store_vat_avg;