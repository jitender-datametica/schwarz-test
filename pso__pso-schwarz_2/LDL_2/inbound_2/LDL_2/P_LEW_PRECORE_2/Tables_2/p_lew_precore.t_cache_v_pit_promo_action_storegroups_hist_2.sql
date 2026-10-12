CREATE TABLE p_lew_precore.t_cache_v_pit_promo_action_storegroups_hist_2
(
client_id SMALLINT NOT NULL,
pvpag_srcinst_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpag_srcinst_code VARCHAR(100) COLLATE 'en-ci',
pvpag_pvpac_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpag_storgrp_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpag_storgrp_code VARCHAR(100) COLLATE 'en-ci',
pvpag_storgrp_name VARCHAR(100) COLLATE 'en-ci',
pvpag_storgrp_type VARCHAR(100) COLLATE 'en-ci',
pvpag_warehs_id VARCHAR(100) COLLATE 'en-ci',
pvpag_warehs_no VARCHAR(100) COLLATE 'en-ci',
pvpag_lsttype_value VARCHAR(100) COLLATE 'en-ci',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
dwh_updated TIMESTAMP(6) NOT NULL,
CONSTRAINT t_cache_v_pit_promo_action_storegroups_hist_pk PRIMARY KEY ( pvpag_srcinst_id ,
pvpag_pvpac_id ,pvpag_storgrp_id ,dwh_valid_from ));

