CREATE TABLE p_lew_precore.t_cache_advert_week_hist
(
client_id SMALLINT NOT NULL,
country_cd CHAR(2) COLLATE 'en-ci' NOT NULL,
valid_from_dt DATE NOT NULL,
valid_to_dt DATE,
plan_first_day VARCHAR(100) COLLATE 'en-ci',
plan_last_day VARCHAR(100) COLLATE 'en-ci',
leaflet_start_day VARCHAR(100) COLLATE 'en-ci',
leaflet_end_day VARCHAR(100) COLLATE 'en-ci',
file_name VARCHAR(100) COLLATE 'en-ci',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
dwh_updated TIMESTAMP(6) NOT NULL,
CONSTRAINT t_cache_advert_week_hist_pk PRIMARY KEY ( country_cd ,
valid_from_dt ,dwh_valid_from ));

