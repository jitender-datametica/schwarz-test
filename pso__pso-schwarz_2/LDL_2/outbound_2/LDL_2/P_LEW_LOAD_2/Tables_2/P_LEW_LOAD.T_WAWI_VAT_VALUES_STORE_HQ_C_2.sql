CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_vat_values_store_hq_c_2 (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(2) COLLATE 'und:ci' NOT NULL,
wh_id_hq BIGNUMERIC(38) NOT NULL,
orig_store_nr BIGNUMERIC(38) NOT NULL,
vat_id BIGNUMERIC(38) NOT NULL,
store_vat_id BIGNUMERIC(38) NOT NULL,
country_cd STRING(3) COLLATE 'und:ci' NOT NULL,
dat_modification DATE,
file_name STRING(100) COLLATE 'und:ci' NOT NULL,
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);