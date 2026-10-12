CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_ref_lil_promotion_brand_1 (
promotion_brand_id INTEGER NOT NULL,
promotion_brand_cd STRING(100),
promotion_brand_descr STRING(100) COLLATE 'und:ci',
promotion_brand_short_descr STRING(100) COLLATE 'und:ci',
promotion_brand_level INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);