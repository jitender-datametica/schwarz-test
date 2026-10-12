CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_actiongroup_desc (client_id, item_sub_actiongroup_id,
item_actiongroup_id, dat_rec_start, dat_rec_end, dat_valid_from, dat_valid_until, item_sub_actgroup_desc,
item_actgroup_desc, language_id, load_id) AS SELECT client_id,
 item_sub_actiongroup_id,
 item_actiongroup_id,
 dat_rec_start,
 dat_rec_end,
 dat_valid_from,
 dat_valid_until,
 item_sub_actgroup_desc,
 item_actgroup_desc,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_actiongroup_desc;