CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_sup_vat_id (
client_id BIGNUMERIC(38,0) NOT NULL,
sup_sid BIGNUMERIC(38,0) NOT NULL,
vat_ident_nr STRING(20) COLLATE 'und:ci' NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
supplier_category_id STRING(25) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL
);