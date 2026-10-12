CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_sfo_claim_reason (client_id, wh_loc_sid, claim_reason_cd,
claim_reason_desc, language_id, dat_lastedit, load_id) AS SELECT client_id,
 wh_loc_sid,
 claim_reason_cd,
 claim_reason_desc,
 language_id,
 dat_lastedit,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_sfo_claim_reason;