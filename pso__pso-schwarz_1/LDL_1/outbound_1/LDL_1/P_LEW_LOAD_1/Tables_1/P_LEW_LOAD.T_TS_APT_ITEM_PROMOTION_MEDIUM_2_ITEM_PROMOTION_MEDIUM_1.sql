CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_apt_item_promotion_medium_2_item_promotion_medium_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
item_sid BIGNUMERIC(38),
promotion_dt DATE,
advertising_medium_cd STRING(100) COLLATE 'und:ci',
advertising_medium_pos STRING(100) COLLATE 'und:ci',
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