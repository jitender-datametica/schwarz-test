CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_wh_interface_1 (client_id, wh_loc_sid, system_key, system_desc,
interface_key, interface_desc, dat_rec_start, dat_rec_end, load_id) AS SELECT client_id,
 wh_loc_sid,
 system_key,
 system_desc,
 interface_key,
 interface_desc,
 dat_rec_start,
 dat_rec_end,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_wh_interface_1;