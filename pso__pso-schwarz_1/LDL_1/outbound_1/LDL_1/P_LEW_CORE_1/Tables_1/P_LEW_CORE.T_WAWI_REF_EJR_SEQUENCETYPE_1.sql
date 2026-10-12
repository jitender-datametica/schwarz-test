CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_ejr_sequencetype_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
sequencetype_id BIGNUMERIC(38,0) NOT NULL,
sequencetype_desc STRING(50) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);