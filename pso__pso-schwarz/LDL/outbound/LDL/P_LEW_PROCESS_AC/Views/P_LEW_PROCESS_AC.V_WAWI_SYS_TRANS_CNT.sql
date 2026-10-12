CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_wawi_sys_trans_cnt (system_key, interface_key, client_id, wh_loc_sid,
st_loc_sid, dat_dayend, trans_row_cnt) AS SELECT system_key,
 interface_key,
 client_id,
 wh_loc_sid,
 st_loc_sid,
 dat_dayend,
 trans_row_cnt
FROM ldl_p_lew_process.t_wawi_sys_trans_cnt;