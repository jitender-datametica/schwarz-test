CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_ejr_transactiontype_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
recordtype_id STRING(1) COLLATE 'und:ci' NOT NULL,
transactiontype_id STRING(3) COLLATE 'und:ci' NOT NULL,
transactiontype1_desc STRING(50) COLLATE 'und:ci',
transactiontype2_desc STRING(50) COLLATE 'und:ci',
transactiontype3_desc STRING(50) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);