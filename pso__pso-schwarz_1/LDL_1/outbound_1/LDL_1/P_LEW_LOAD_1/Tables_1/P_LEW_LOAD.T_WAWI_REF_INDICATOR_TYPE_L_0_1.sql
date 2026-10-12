CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_ref_indicator_type_l_0_1 (
indicator_type_id BIGNUMERIC(38) NOT NULL,
indicator_type_desc STRING(100) COLLATE 'und:ci' NOT NULL,
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