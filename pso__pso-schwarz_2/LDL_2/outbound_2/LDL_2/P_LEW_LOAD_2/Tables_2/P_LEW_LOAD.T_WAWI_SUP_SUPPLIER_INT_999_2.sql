CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_sup_supplier_int_999_2 (
client_id BIGNUMERIC(38) NOT NULL,
sup_sid_int STRING(10) COLLATE 'und:ci' NOT NULL,
sup_sid BIGNUMERIC(38) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
supplier_desc_int STRING(50) COLLATE 'und:ci',
language_id BIGNUMERIC(38) NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);