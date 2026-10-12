CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_stc_slot_area_desc_1 (client_id, wh_loc_sid, stc_slot_area, language_id,
dat_rec_start, dat_rec_end, stc_slot_name, stc_slot_short_name, load_id) AS SELECT client_id,
 wh_loc_sid,
 stc_slot_area,
 language_id,
 dat_rec_start,
 dat_rec_end,
 stc_slot_name,
 stc_slot_short_name,
 load_id
FROM ldl_p_lew_core.t_wawi_stc_slot_area_desc_1;