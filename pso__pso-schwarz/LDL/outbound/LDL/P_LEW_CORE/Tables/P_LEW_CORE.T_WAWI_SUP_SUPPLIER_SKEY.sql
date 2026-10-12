CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_sup_supplier_skey (
client_id BIGNUMERIC(38,0) NOT NULL,
sup_sid BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
orig_supplier_nr STRING(7) COLLATE 'und:ci' NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);