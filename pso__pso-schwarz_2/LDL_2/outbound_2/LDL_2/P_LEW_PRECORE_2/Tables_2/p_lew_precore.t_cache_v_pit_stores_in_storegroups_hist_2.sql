CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_v_pit_stores_in_storegroups_hist_2 (
client_id INTEGER NOT NULL,
pvssg_srcinst_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvssg_srcinst_code STRING(100) COLLATE 'und:ci',
pvssg_storgrp_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvssg_store_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvssg_store_no STRING(100) COLLATE 'und:ci',
pvssg_store_name STRING(100) COLLATE 'und:ci',
pvssg_valid_from DATE,
pvssg_valid_to DATE,
deleted_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (dwh_valid_from) NOT ENFORCED
);