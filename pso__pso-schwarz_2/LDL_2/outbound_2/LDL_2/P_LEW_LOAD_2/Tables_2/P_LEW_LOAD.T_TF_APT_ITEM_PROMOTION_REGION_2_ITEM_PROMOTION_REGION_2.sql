CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_apt_item_promotion_region_2_item_promotion_region_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
apt_item_promotion_region_item BIGNUMERIC(38,0) NOT NULL,
apt_item_promotion_region_land STRING(300),
apt_item_promotion_region_werbetag STRING(300),
apt_item_promotion_region_werberegion STRING(300),
item_2 INTEGER NOT NULL,
promotion_dt DATE,
region_cd STRING(100) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);