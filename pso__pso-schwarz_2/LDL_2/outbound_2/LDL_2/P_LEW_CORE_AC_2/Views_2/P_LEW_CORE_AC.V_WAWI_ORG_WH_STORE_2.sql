CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_wh_store_2 (client_id, st_loc_sid, wh_type_id, dat_rec_start,
dat_rec_end, wh_loc_sid, load_id) AS SELECT client_id,
 st_loc_sid,
 wh_type_id,
 dat_rec_start,
 dat_rec_end,
 wh_loc_sid,
 load_id
FROM ldl_p_lew_core.t_wawi_org_wh_store_2;