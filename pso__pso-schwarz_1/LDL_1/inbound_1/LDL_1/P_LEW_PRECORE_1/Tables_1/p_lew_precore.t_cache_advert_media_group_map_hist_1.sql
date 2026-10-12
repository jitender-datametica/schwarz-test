CREATE TABLE p_lew_precore.t_cache_advert_media_group_map_hist_1
(
client_id SMALLINT NOT NULL,
country_cd CHAR(2) COLLATE 'en-ci' NOT NULL,
adv_medium_id SMALLINT NOT NULL,
adv_media_grp_id SMALLINT NOT NULL,
display_fg BYTEINT,
display_seq INTEGER,
file_name VARCHAR(100) COLLATE 'en-ci',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
dwh_updated TIMESTAMP(6) NOT NULL,
CONSTRAINT t_cache_advert_media_group_map_hist_pk PRIMARY KEY ( country_cd ,
adv_medium_id ,adv_media_grp_id ,dwh_valid_from ));

