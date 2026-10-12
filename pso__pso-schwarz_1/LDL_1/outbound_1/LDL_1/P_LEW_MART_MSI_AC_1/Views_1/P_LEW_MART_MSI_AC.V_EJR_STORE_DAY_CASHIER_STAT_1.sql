CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_store_day_cashier_stat_1 (client_id, store_id, cashier_id, dat_formdate
, val_shouldbe_turnover, cnt_customer, val_avg_purchase, cnt_pos_total, val_pos_per_minute, val_pos_per_purchase,
val_servicetime) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_store_day_cashier_stat_1;