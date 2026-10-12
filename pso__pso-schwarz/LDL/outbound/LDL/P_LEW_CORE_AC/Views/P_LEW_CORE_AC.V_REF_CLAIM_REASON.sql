CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_claim_reason (client_id, loc_sid_wh, claim_reason_id, claim_reason_descr
, last_edit_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 loc_sid_wh,
 claim_reason_id,
 claim_reason_descr,
 last_edit_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_claim_reason;