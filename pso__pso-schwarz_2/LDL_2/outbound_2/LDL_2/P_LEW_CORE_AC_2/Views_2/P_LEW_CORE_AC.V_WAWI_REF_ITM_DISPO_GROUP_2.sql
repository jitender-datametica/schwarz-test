CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_itm_dispo_group_2 (client_id, dispo_group_id, dat_rec_end,
dat_rec_start, dispo_group_desc, language_id, load_id) AS SELECT client_id,
 dispo_group_id,
 dat_rec_end,
 dat_rec_start,
 dispo_group_desc,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_itm_dispo_group_2;