CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_itm_logist_unit (
client_id BIGNUMERIC(38,0) NOT NULL,
logistic_unit_cd BIGNUMERIC(38,0) NOT NULL,
logistic_unit_desc STRING(10) COLLATE 'und:ci' NOT NULL,
logistic_base_unit STRING(10) COLLATE 'und:ci',
logistic_base_factor NUMERIC(18,4),
logistic_base_unit_int STRING(10) COLLATE 'und:ci',
logistic_base_factor_int NUMERIC(18,4),
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);