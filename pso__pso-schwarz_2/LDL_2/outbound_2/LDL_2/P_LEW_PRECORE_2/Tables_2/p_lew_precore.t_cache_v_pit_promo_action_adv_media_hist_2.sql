CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_v_pit_promo_action_adv_media_hist_2 (
client_id INTEGER NOT NULL,
pvpam_srcinst_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpam_srcinst_code STRING(100) COLLATE 'und:ci',
pvpam_pvpac_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpam_advmed_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpam_advmed_type STRING(100) COLLATE 'und:ci',
pvpam_advmed_short_description STRING(100) COLLATE 'und:ci',
deleted_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (dwh_valid_from) NOT ENFORCED
);