CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_itm_dispo_unit_2 (client_id, dispo_unit_id, dispo_unit_desc,
language_id, dat_rec_start, dat_rec_end, load_id) AS SELECT client_id,
 dispo_unit_id,
 dispo_unit_desc,
 language_id,
 dat_rec_start,
 dat_rec_end,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_itm_dispo_unit_2;