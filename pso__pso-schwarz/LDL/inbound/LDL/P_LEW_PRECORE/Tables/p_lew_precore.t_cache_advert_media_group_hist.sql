CREATE TABLE p_lew_precore.t_cache_advert_media_group_hist (
client_id SMALLINT NOT NULL,
adv_media_grp_id SMALLINT NOT NULL,
adv_media_grp_de_name VARCHAR(100) COLLATE 'en-ci',
adv_media_grp_en_name VARCHAR(100) COLLATE 'en-ci',
display_seq INTEGER,
lplus_fg BYTEINT,
file_name VARCHAR(100) COLLATE 'en-ci',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
dwh_updated TIMESTAMP(6) NOT NULL,
CONSTRAINT t_cache_advert_media_group_hist_pk PRIMARY KEY ( adv_media_grp_id ,
dwh_valid_from )
);

