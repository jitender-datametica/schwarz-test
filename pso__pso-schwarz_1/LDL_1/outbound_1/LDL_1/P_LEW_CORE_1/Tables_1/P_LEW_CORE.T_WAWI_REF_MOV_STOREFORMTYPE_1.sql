CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_mov_storeformtype_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
sfotype_id BIGNUMERIC(38,0) NOT NULL,
sfotype_desc STRING(50) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);