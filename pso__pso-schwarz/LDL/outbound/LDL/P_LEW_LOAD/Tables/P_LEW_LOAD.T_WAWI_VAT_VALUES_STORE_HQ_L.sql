CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_vat_values_store_hq_l (
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