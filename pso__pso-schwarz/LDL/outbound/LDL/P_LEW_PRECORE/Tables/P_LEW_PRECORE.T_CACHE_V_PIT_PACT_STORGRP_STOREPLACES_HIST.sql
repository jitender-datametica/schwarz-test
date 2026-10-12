CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_v_pit_pact_storgrp_storeplaces_hist (
client_id BIGNUMERIC(38,0) NOT NULL,
pvpgs_srcinst_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpgs_srcinst_code STRING(100) COLLATE 'und:ci',
pvpgs_pvpac_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpgs_strplm_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpgs_proplan_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpgs_storgrp_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvpgs_strplm_type STRING(100) COLLATE 'und:ci',
pvpgs_strplm_short_description STRING(100) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (dwh_valid_from) NOT ENFORCED
);