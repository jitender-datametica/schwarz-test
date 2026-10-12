CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_wawi_sys_md_storelist_1 (client_id, wh_loc_sid, st_loc_sid, dat_open,
dat_dayend, timestamp_fn, load_id) AS SELECT client_id,
 wh_loc_sid,
 st_loc_sid,
 dat_open,
 dat_dayend,
 timestamp_fn,
 load_id
FROM ldl_p_lew_process.t_wawi_sys_md_storelist_1;