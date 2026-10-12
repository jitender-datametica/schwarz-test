CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_v_pit_promotion_item_relations_hist_2 (
client_id INTEGER NOT NULL,
pvpir_srcinst_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpir_srcinst_code STRING(100) COLLATE 'und:ci',
pvpir_pvpit_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpir_related_pvpit_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpir_reltype_value STRING(100) COLLATE 'und:ci',
deleted_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (dwh_valid_from) NOT ENFORCED
);