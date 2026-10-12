CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_advert_week_hist_1 (
client_id INTEGER NOT NULL,
country_cd STRING COLLATE 'und:ci' NOT NULL,
valid_from_dt DATE NOT NULL,
valid_to_dt DATE,
plan_first_day STRING(100) COLLATE 'und:ci',
plan_last_day STRING(100) COLLATE 'und:ci',
leaflet_start_day STRING(100) COLLATE 'und:ci',
leaflet_end_day STRING(100) COLLATE 'und:ci',
file_name STRING(100) COLLATE 'und:ci',
deleted_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (valid_from_dt, dwh_valid_from) NOT ENFORCED
);