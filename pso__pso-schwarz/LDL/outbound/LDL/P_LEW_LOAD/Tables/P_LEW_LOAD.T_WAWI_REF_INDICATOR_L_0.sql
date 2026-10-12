CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_ref_indicator_l_0 (
indicator_id BIGNUMERIC(38) NOT NULL,
indicator_desc STRING(200) COLLATE 'und:ci' NOT NULL,
indicator_valuetype STRING(15) COLLATE 'und:ci',
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
extraction_date DATE,
record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci',
timestamp_fn DATETIME NOT NULL,
dc_server_id BIGNUMERIC(38) NOT NULL
);