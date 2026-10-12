CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_sup_category_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
supplier_category_id STRING(35) COLLATE 'und:ci',
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
supplier_category_desc STRING(80) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL
);