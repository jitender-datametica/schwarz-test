CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_10_231_ptm_holiday_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
landkzl STRING(20) COLLATE 'und:ci' NOT NULL,
whnr STRING(20) COLLATE 'und:ci' NOT NULL,
loc_sid_wh BIGNUMERIC(38,0) NOT NULL,
region_id STRING(200) COLLATE 'und:ci' NOT NULL,
holiday_date DATE NOT NULL,
holiday_week BIGNUMERIC(38,0),
description STRING(200) COLLATE 'und:ci' NOT NULL,
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (holiday_date, dwh_valid_from) NOT ENFORCED
);