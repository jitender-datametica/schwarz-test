CREATE TABLE p_lew_precore.t_cache_v_pit_stores_in_storegroups_hist
(
client_id SMALLINT NOT NULL,
pvssg_srcinst_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvssg_srcinst_code VARCHAR(100) COLLATE 'en-ci',
pvssg_storgrp_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvssg_store_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvssg_store_no VARCHAR(100) COLLATE 'en-ci',
pvssg_store_name VARCHAR(100) COLLATE 'en-ci',
pvssg_valid_from DATE,
pvssg_valid_to DATE,
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
dwh_updated TIMESTAMP(6) NOT NULL,
CONSTRAINT t_cache_v_pit_stores_in_storegroups_hist_pk PRIMARY KEY ( pvssg_srcinst_id ,
pvssg_storgrp_id ,pvssg_store_id ,dwh_valid_from ));

