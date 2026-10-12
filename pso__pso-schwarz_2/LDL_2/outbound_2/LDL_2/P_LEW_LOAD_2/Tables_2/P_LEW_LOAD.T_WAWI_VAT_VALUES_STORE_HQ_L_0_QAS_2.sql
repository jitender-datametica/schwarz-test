CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_vat_values_store_hq_l_0_qas_2 (
country_iso_cd STRING(2) COLLATE 'und:ci' NOT NULL,
wh_id_hq BIGNUMERIC(38,0) NOT NULL,
orig_store_nr BIGNUMERIC(38,0) NOT NULL,
vat_id BIGNUMERIC(38,0) NOT NULL,
store_vat_id BIGNUMERIC(38,0) NOT NULL,
country_cd STRING(3) COLLATE 'und:ci' NOT NULL,
dat_modification DATE,
file_name STRING(100) COLLATE 'und:ci' NOT NULL,
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
dc_server_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci'
);