CREATE OR REPLACE VIEW ldl_p_lew_process.v_agc_core_table_update_2 (core_table_name, client_id, dwh_cal_dt, recalc_fg,
create_timestamp, dwh_load_id) AS SELECT core_table_name,
 client_id,
 dwh_cal_dt,
 recalc_fg,
 create_timestamp,
 dwh_load_id
FROM ldl_p_lew_process.t_agc_core_table_update_2;