CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_pricegroup_1 (client_id, pricegroup_id, wh_loc_sid, st_loc_sid,
dat_valid_from, dat_valid_until, pricegroup_desc, priority, language_id, load_id) AS SELECT client_id,
 pricegroup_id,
 wh_loc_sid,
 st_loc_sid,
 dat_valid_from,
 dat_valid_until,
 pricegroup_desc,
 priority,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_pricegroup_1;