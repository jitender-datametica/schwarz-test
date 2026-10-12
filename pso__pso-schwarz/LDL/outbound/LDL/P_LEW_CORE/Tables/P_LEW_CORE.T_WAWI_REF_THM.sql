CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_thm (
client_id BIGNUMERIC(38,0) NOT NULL,
orig_thm_nr STRING(20) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
thm_desc STRING(35) COLLATE 'und:ci' NOT NULL,
factor_ep NUMERIC(18,4) DEFAULT 1,
load_id BIGNUMERIC(38,0) NOT NULL
);