CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_claim_reason (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_wh BIGNUMERIC(38,0) NOT NULL,
claim_reason_id BIGNUMERIC(38,0) NOT NULL,
claim_reason_descr STRING(100),
last_edit_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id;