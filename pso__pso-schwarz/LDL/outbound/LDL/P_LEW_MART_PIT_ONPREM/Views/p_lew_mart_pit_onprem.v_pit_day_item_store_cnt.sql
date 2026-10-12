CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_day_item_store_cnt AS SELECT client_id,
 dwh_cal_dt,
 cy_month,
 f_client_store_cnt,
 f_client_store_cnt_month,
 IF(f_client_store_cnt_month = 0, 0, SAFE_DIVIDE(f_client_store_cnt, f_client_store_cnt_month)) AS
 f_diff_store_cnt_to_month
FROM ldl_p_lew_mart_pit_onprem.t_pit_day_item_store_cnt;