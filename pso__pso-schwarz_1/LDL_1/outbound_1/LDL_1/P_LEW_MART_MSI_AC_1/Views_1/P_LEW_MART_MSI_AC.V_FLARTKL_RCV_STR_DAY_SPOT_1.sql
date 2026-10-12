CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_flartkl_rcv_str_day_spot_1 (client_id, wh_id, aspect_id, store_id,
currency_iso_cd, business_yr, month_id, week_id, dat_calendar, last_cwd_fg, last_cmd_fg, dup_fg, val_cnt_asis,
val_sum_asis, p1y_cwd_val_cnt, p1y_cmd_val_cnt, p1y_cwd_val_sum, p1y_cmd_val_sum) AS SELECT *
FROM ldl_p_lew_mart_msi.v_flartkl_rcv_str_day_spot_1;