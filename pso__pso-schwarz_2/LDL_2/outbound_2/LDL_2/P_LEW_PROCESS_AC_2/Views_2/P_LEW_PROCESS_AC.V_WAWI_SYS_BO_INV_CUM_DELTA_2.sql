CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_wawi_sys_bo_inv_cum_delta_2 (client_id, wh_loc_sid, st_loc_sid, busyear) AS
SELECT client_id,
 wh_loc_sid,
 st_loc_sid,
 busyear
FROM ldl_p_lew_process.t_wawi_sys_bo_inv_cum_delta_2;