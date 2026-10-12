CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_apt_item_promotion_region_2_item_promotion_region_2 (
record_id INTEGER,
client_id BIGNUMERIC(38),
item_sid BIGNUMERIC(38),
promotion_dt DATE,
region_cd STRING(100) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);