CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_period_l_0_2 (
country_iso_cd STRING(3) COLLATE 'und:ci',
factor_period BIGNUMERIC(38),
shelflife_desc STRING(15) COLLATE 'und:ci',
shelflife_short_desc STRING(20) COLLATE 'und:ci',
shelflife_id STRING(5) COLLATE 'und:ci' NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38) NOT NULL,
dc_server_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci'
);