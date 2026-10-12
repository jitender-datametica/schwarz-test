CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_advert_media_group_map_hist_2 (
client_id INTEGER NOT NULL,
country_cd STRING COLLATE 'und:ci' NOT NULL,
adv_medium_id INTEGER NOT NULL,
adv_media_grp_id INTEGER NOT NULL,
display_fg INTEGER,
display_seq INTEGER,
file_name STRING(100) COLLATE 'und:ci',
deleted_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (adv_medium_id, adv_media_grp_id, dwh_valid_from) NOT ENFORCED
);