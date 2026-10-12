CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_wawi_wh_new_1 (client_id, country_iso_cd, wh_id, dat_dayend,
dat_dayend_mmo_master, dat_dayend_mmo_move, wh_new_loc_sid, wh_new_time_trans, wh_new_status, wh_new_err_text) AS SELECT
 client_id,
 country_iso_cd,
 wh_id,
 dat_dayend,
 dat_dayend_mmo_master,
 dat_dayend_mmo_move,
 wh_new_loc_sid,
 wh_new_time_trans,
 wh_new_status,
 wh_new_err_text
FROM ldl_p_lew_process.t_wawi_wh_new_1;