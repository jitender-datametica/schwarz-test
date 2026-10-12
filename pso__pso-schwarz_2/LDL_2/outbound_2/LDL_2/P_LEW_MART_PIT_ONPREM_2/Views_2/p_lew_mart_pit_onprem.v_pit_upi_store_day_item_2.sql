CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_upi_store_day_item_2 (client_id, store_sid, dwh_cal_dt, item_sid,
effective_client_id, luxembourg_fg) AS SELECT client_id,
 store_sid,
 dwh_cal_dt,
 item_sid,
 effective_client_id,
 luxembourg_fg
FROM ldl_p_lew_mart_pit_onprem.t_pit_upi_store_day_item_2 AS UPI;