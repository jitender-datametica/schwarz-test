CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_sys_load_status_store_log_2 (run_id, client_id, st_loc_sid, kpi_id,
dat_dayend, rec_cnt, run_tmsp) AS SELECT run_id,
 client_id,
 st_loc_sid,
 kpi_id,
 dat_dayend,
 rec_cnt,
 run_tmsp
FROM ldl_p_lew_mart_msi.t_sys_load_status_store_log_2;