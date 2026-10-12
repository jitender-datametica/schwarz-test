CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_supp_vat_hq_c_2 (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
orig_supplier_nr STRING(7) COLLATE 'und:ci' NOT NULL,
vat_ident_nr STRING(20) COLLATE 'und:ci' NOT NULL,
supplier_category_id STRING(25) COLLATE 'und:ci',
dat_modification DATE,
file_name STRING(100) COLLATE 'und:ci' NOT NULL,
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);