CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_lil_promotion_brand (
promotion_brand_id BIGNUMERIC(38,0) NOT NULL,
promotion_brand_cd STRING(100),
promotion_brand_descr STRING(100) COLLATE 'und:ci',
promotion_brand_short_descr STRING(100) COLLATE 'und:ci',
promotion_brand_level BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);