CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_10_230_ptm_region_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
landkzl STRING(20) COLLATE 'und:ci' NOT NULL,
whno STRING(20) COLLATE 'und:ci' NOT NULL,
loc_sid_wh BIGNUMERIC(38,0),
region_code STRING(20) COLLATE 'und:ci' NOT NULL,
region_id STRING(200) COLLATE 'und:ci' NOT NULL,
description STRING(200) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (dwh_valid_from) NOT ENFORCED
);