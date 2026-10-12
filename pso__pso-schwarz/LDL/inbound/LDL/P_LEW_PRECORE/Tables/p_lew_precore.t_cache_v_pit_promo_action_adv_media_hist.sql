CREATE TABLE p_lew_precore.t_cache_v_pit_promo_action_adv_media_hist
(
client_id SMALLINT NOT NULL,
pvpam_srcinst_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpam_srcinst_code VARCHAR(100) COLLATE 'en-ci',
pvpam_pvpac_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpam_advmed_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpam_advmed_type VARCHAR(100) COLLATE 'en-ci',
pvpam_advmed_short_description VARCHAR(100) COLLATE 'en-ci',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
dwh_updated TIMESTAMP(6) NOT NULL,
CONSTRAINT t_cache_v_pit_promo_action_adv_media_hist_pk PRIMARY KEY ( pvpam_srcinst_id ,
pvpam_pvpac_id ,pvpam_advmed_id ,dwh_valid_from ));

