CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_wawi_sys_bo_inv_delta_2 (client_id, wh_loc_sid, st_loc_sid, inv_id,
dat_formdate, dat_valid_from, dat_valid_until, cy_month, busyear) AS SELECT client_id,
 wh_loc_sid,
 st_loc_sid,
 inv_id,
 dat_formdate,
 dat_valid_from,
 dat_valid_until,
 cy_month,
 busyear
FROM ldl_p_lew_process.t_wawi_sys_bo_inv_delta_2;