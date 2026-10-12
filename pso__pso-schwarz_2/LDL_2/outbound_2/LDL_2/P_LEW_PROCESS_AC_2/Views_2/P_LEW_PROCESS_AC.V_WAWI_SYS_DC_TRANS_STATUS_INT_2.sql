CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_wawi_sys_dc_trans_status_int_2 (load_id, dc_server_id, dc_load_id,
country_iso_cd, wh_id, dat_dayend, etl_type, interface_name, l_0_cnt, l_cnt, timestamp_start, timestamp_end) AS SELECT
 load_id,
 dc_server_id,
 dc_load_id,
 country_iso_cd,
 wh_id,
 dat_dayend,
 etl_type,
 interface_name,
 l_0_cnt,
 l_cnt,
 timestamp_start,
 timestamp_end
FROM ldl_p_lew_process.t_wawi_sys_dc_trans_status_int_2;