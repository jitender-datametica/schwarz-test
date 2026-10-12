CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_apt_item_promotion_medium_2_item_promotion_medium_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
apt_item_promotion_medium_item BIGNUMERIC(38,0) NOT NULL,
apt_item_promotion_medium_land STRING(300),
apt_item_promotion_medium_werbetag STRING(300),
apt_item_promotion_medium_werbemittel STRING(300),
item_2 INTEGER NOT NULL,
promotion_dt DATE,
advertising_medium_cd STRING(100) COLLATE 'und:ci',
advertising_medium_pos STRING(100) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);