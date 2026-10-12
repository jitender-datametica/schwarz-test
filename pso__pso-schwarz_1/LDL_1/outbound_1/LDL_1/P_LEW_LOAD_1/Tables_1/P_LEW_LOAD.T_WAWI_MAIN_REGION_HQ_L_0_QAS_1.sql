CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_main_region_hq_l_0_qas_1 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
main_region_id BIGNUMERIC(38,0) NOT NULL,
countrycode STRING(3) COLLATE 'und:ci' NOT NULL,
name STRING(35) COLLATE 'und:ci' NOT NULL,
short_name STRING(10) COLLATE 'und:ci' NOT NULL,
region_type_id BIGNUMERIC(38,0) NOT NULL,
scn BIGNUMERIC(38,0),
dat_dayend DATE,
load_id BIGNUMERIC(38,0),
dc_server_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci'
);