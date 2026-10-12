CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_pcwo_reason_hq_l (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
pcwo_reason_id BIGNUMERIC(38) NOT NULL,
pcwo_reason_id_int BIGNUMERIC(38) NOT NULL,
pcwo_group_id BIGNUMERIC(38),
pcwo_reason_desc_int STRING(50) COLLATE 'und:ci',
pcwo_reason_desc_nat STRING(50) COLLATE 'und:ci' NOT NULL,
pcwo_group_desc STRING(50) COLLATE 'und:ci',
pcwo_active_fg BIGNUMERIC(38) NOT NULL,
pcwo_new_group_cd BIGNUMERIC(38),
file_name STRING(100) COLLATE 'und:ci' NOT NULL,
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38) NOT NULL
);