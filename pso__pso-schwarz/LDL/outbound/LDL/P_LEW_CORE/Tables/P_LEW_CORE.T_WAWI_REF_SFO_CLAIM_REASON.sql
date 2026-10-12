CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_sfo_claim_reason (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
claim_reason_cd BIGNUMERIC(38,0) NOT NULL,
claim_reason_desc STRING(50) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0) NOT NULL,
dat_lastedit DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);