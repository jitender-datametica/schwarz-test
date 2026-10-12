CREATE TABLE p_lew_precore.t_cache_v_pit_promotion_action_prices_hist
(
client_id SMALLINT NOT NULL,
pvpap_srcinst_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpap_srcinst_code VARCHAR(100) COLLATE 'en-ci',
pvpap_pvpac_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpap_salestype_value VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvpap_no SMALLINT NOT NULL,
pvpap_valid_from DATE NOT NULL,
pvpap_valid_to DATE,
pvpap_price_action_curry_code VARCHAR(100) COLLATE 'en-ci',
pvpap_selling_price_action DECIMAL(18,5),
pvpap_selling_price_comment VARCHAR(1000) COLLATE 'en-ci',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
dwh_updated TIMESTAMP(6) NOT NULL,
CONSTRAINT t_cache_v_pit_promotion_action_prices_hist_pk PRIMARY KEY ( pvpap_srcinst_id ,
pvpap_pvpac_id ,pvpap_salestype_value ,pvpap_no ,pvpap_valid_from ,
dwh_valid_from ));

