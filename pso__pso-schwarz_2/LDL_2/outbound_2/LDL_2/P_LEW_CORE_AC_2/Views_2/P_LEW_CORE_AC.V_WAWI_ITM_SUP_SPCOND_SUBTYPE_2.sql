CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_sup_spcond_subtype_2 (client_id, spcond_subtype_id, dat_rec_start,
dat_rec_end, spcond_subtype_desc, language_id, load_id) AS SELECT client_id,
 spcond_subtype_id,
 dat_rec_start,
 dat_rec_end,
 spcond_subtype_desc,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_sup_spcond_subtype_2;