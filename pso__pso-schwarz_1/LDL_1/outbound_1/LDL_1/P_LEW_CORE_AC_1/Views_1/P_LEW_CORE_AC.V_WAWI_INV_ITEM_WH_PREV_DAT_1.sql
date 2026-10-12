CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_inv_item_wh_prev_dat_1 (client_id, wh_loc_sid, inv_id, dat_formdate,
prev_dat_formdate) AS SELECT client_id,
 wh_loc_sid,
 inv_id,
 dat_formdate,
 prev_dat_formdate
FROM ldl_p_lew_core.t_wawi_inv_item_wh_prev_dat_1;