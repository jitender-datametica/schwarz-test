CREATE TABLE p_lew_precore.t_cache_v_pit_warehouses_hist_2
(
client_id SMALLINT NOT NULL,
srcinst_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
srcinst_code VARCHAR(100) COLLATE 'en-ci',
cntry_id VARCHAR(100) COLLATE 'en-ci',
cntry_code VARCHAR(20) COLLATE 'en-ci',
warehs_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
warehs_no VARCHAR(100) COLLATE 'en-ci',
warehs_code VARCHAR(20) COLLATE 'en-ci',
warehs_name VARCHAR(100) COLLATE 'en-ci',
warehs_valid_from DATE,
warehs_valid_to DATE,
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
dwh_updated TIMESTAMP(6) NOT NULL,
CONSTRAINT t_cache_v_pit_promotion_deliveries_hist_pk PRIMARY KEY ( srcinst_id ,
warehs_id ,dwh_valid_from ));

