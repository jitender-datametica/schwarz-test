CREATE TABLE p_lew_precore.t_cache_v_pit_item_sellingprices_hist_2
(
client_id SMALLINT NOT NULL,
pvisp_srcinst_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvisp_srcinst_code VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvisp_pvpit_id VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvisp_salestype_value VARCHAR(100) COLLATE 'en-ci' NOT NULL,
pvisp_no SMALLINT NOT NULL,
pvisp_selling_price DECIMAL(18,5),
pvisp_selling_price_curry_code VARCHAR(100) COLLATE 'en-ci',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
dwh_updated TIMESTAMP(6) NOT NULL,
CONSTRAINT t_cache_v_pit_item_sellingprices_hist_pk PRIMARY KEY ( pvisp_srcinst_id ,
pvisp_pvpit_id ,pvisp_salestype_value ,pvisp_no ,dwh_valid_from ));

