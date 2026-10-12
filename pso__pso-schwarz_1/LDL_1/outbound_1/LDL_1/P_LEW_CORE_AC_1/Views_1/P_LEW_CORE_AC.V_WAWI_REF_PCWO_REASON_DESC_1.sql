CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_pcwo_reason_desc_1 (client_id, pcwo_reason_id, language_id,
dat_rec_start, dat_rec_end, pcwo_reason_desc, load_id) AS SELECT client_id,
 pcwo_reason_id,
 language_id,
 dat_rec_start,
 dat_rec_end,
 pcwo_reason_desc,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_pcwo_reason_desc_1;