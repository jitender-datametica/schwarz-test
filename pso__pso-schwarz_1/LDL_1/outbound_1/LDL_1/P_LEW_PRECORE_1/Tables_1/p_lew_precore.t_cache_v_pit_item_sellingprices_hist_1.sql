CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_v_pit_item_sellingprices_hist_1 (
client_id INTEGER NOT NULL,
pvisp_srcinst_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvisp_srcinst_code STRING(100) COLLATE 'und:ci' NOT NULL,
pvisp_pvpit_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvisp_salestype_value STRING(100) COLLATE 'und:ci' NOT NULL,
pvisp_no INTEGER NOT NULL,
pvisp_selling_price NUMERIC(18,5),
pvisp_selling_price_curry_code STRING(100) COLLATE 'und:ci',
deleted_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (pvisp_no, dwh_valid_from) NOT ENFORCED
);