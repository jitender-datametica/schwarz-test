CREATE TABLE p_lew_precore.t_cache_v_pit_promo_action_storeplaces_hist
(
client_id SMALLINT NOT NULL,
pvpas_srcinst_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpas_srcinst_code VARCHAR(100) COLLATE 'en-ci',
pvpas_pvpac_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpas_strplm_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpas_strplm_type VARCHAR(100) COLLATE 'en-ci',
pvpas_strplm_short_description VARCHAR(100) COLLATE 'en-ci',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
dwh_updated TIMESTAMP(6) NOT NULL,
CONSTRAINT t_cache_v_pit_promo_action_storeplaces_hist_pk PRIMARY KEY ( pvpas_srcinst_id ,
pvpas_pvpac_id ,pvpas_strplm_id ,dwh_valid_from ));

