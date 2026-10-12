CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_statisticgroup_1 (client_id, statisticgroup_id, dat_rec_start,
dat_rec_end, dat_valid_from, dat_valid_until, statisticgroup_desc, edit_fg, statisticgroup_position, language_id,
load_id) AS SELECT client_id,
 statisticgroup_id,
 dat_rec_start,
 dat_rec_end,
 dat_valid_from,
 dat_valid_until,
 statisticgroup_desc,
 edit_fg,
 statisticgroup_position,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_statisticgroup_1;