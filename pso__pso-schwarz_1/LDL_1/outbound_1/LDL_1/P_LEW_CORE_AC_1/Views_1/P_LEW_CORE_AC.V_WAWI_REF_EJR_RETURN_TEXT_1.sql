CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_ejr_return_text_1 (client_id, return_reason_cd_ejr, comment_string,
language_id, dat_rec_start, dat_rec_end, load_id) AS SELECT client_id,
 return_reason_cd_ejr,
 comment_string,
 language_id,
 dat_rec_start,
 dat_rec_end,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_ejr_return_text_1;