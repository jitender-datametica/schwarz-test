CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_wawi_sys_dc_trans_dayend_int_2 (country_iso_cd, data_type, interface,
dat_dayend, wh_id, time_trans) AS SELECT country_iso_cd,
 data_type,
 interface,
 dat_dayend,
 wh_id,
 time_trans
FROM ldl_p_lew_process.t_wawi_sys_dc_trans_dayend_int_2;