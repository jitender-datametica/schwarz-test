CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_sup_supplier_int (
client_id BIGNUMERIC(38,0) NOT NULL,
sup_sid_int STRING(10) COLLATE 'und:ci' NOT NULL,
sup_sid BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
supplier_desc_int STRING(50) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);