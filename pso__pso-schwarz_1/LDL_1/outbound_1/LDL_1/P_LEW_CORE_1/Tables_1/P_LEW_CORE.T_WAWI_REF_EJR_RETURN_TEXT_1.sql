CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_ejr_return_text_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
return_reason_cd_ejr STRING(2) COLLATE 'und:ci' NOT NULL,
comment_string STRING(100) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);