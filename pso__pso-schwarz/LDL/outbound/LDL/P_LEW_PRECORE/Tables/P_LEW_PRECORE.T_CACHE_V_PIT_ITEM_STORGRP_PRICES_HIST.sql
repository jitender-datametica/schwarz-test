CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_v_pit_item_storgrp_prices_hist (
client_id BIGNUMERIC(38,0) NOT NULL,
pvigp_srcinst_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvigp_srcinst_code STRING(100) COLLATE 'und:ci' NOT NULL,
pvigp_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvigp_pvpit_id STRING(100) COLLATE 'und:ci',
pvigp_salestype_value STRING(100) COLLATE 'und:ci',
pvigp_no BIGNUMERIC(38,0),
pvigp_storgrp_id STRING(100) COLLATE 'und:ci' NOT NULL,
pvigp_selling_price NUMERIC(18,5),
pvigp_selling_price_curry_code STRING(100) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (dwh_valid_from) NOT ENFORCED
);