CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_client_desc_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
client_desc STRING(35) COLLATE 'und:ci' NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);