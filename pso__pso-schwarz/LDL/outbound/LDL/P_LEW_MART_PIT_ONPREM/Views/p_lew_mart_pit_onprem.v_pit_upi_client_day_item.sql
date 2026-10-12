CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_upi_client_day_item (client_id, dwh_cal_dt, item_sid) AS SELECT
 client_id,
 dwh_cal_dt,
 item_sid
FROM ldl_p_lew_mart_pit_onprem.t_pit_upi_client_day_item AS UPI;