CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_ref_indicator_l_2 (
indicator_id BIGNUMERIC(38) NOT NULL,
indicator_desc STRING(200) COLLATE 'und:ci' NOT NULL,
indicator_valuetype STRING(15) COLLATE 'und:ci',
file_name STRING(100) COLLATE 'und:ci' NOT NULL,
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);