CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_v_pit_promo_action_storeplaces_hist (
client_id INTEGER NOT NULL,
pvpas_srcinst_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpas_srcinst_code STRING(100) COLLATE 'und:ci',
pvpas_pvpac_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpas_strplm_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpas_strplm_type STRING(100) COLLATE 'und:ci',
pvpas_strplm_short_description STRING(100) COLLATE 'und:ci',
deleted_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (dwh_valid_from) NOT ENFORCED
);