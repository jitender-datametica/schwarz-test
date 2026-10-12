CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_ref_sup_start_type_999_1 (
client_id BIGNUMERIC(38) NOT NULL,
start_type_cd BIGNUMERIC(38) NOT NULL,
dat_rec_end DATE NOT NULL,
dat_rec_start DATE NOT NULL,
start_type_desc STRING(50) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38) NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);