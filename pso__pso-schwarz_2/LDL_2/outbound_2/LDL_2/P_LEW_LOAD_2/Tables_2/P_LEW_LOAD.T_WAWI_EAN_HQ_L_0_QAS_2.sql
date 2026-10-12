CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_ean_hq_l_0_qas_2 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
item_nr_long STRING(14) COLLATE 'und:ci' NOT NULL,
orig_item_nr INTEGER NOT NULL,
case_size BIGNUMERIC(38,0) NOT NULL,
ean_2 STRING(13) COLLATE 'und:ci' NOT NULL,
ean_item_desc STRING(30) COLLATE 'und:ci',
custom_nr STRING(20) COLLATE 'und:ci',
custom_key STRING(10) COLLATE 'und:ci',
online_desc STRING(250) COLLATE 'und:ci',
dat_dayend DATE,
load_id BIGNUMERIC(38,0),
dc_server_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci'
);