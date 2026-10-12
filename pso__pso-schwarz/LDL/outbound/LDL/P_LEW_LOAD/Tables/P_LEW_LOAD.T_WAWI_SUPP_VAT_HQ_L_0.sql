CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_supp_vat_hq_l_0 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
orig_supplier_nr STRING(7) COLLATE 'und:ci' NOT NULL,
vat_ident_nr STRING(20) COLLATE 'und:ci' NOT NULL,
supplier_category_id STRING(25) COLLATE 'und:ci',
dat_modification DATE,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL,
dc_server_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci'
);