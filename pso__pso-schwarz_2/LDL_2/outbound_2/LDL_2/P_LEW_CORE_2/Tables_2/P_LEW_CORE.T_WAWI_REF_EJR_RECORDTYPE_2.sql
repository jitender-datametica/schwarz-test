CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_ejr_recordtype_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
recordtype_id STRING(1) COLLATE 'und:ci' NOT NULL,
recordtype_desc STRING(50) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);