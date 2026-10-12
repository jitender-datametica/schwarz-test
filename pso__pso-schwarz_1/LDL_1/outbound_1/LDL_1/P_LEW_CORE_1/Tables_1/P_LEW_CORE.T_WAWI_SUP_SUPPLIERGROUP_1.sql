CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_sup_suppliergroup_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
suppliergroup_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
suppliergroup_desc STRING(35) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);