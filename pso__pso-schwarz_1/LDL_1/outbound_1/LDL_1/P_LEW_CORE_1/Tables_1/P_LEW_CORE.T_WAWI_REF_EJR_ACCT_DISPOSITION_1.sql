CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_ejr_acct_disposition_1 (
accounting_disposition_cd_ejr STRING(4) COLLATE 'und:ci' NOT NULL,
comment_string STRING(100) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
dat_lastedit DATE NOT NULL,
user_lastedit STRING(30) COLLATE 'und:ci' NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);