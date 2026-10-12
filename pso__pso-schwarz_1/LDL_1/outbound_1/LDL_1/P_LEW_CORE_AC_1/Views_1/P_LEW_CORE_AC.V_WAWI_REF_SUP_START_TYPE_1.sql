CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_sup_start_type_1 (client_id, start_type_cd, dat_rec_end, dat_rec_start
, start_type_desc, language_id, load_id) AS SELECT client_id,
 start_type_cd,
 dat_rec_end,
 dat_rec_start,
 start_type_desc,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_sup_start_type_1;