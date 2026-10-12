CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_itm_missing_2_item_missing_2 (
record_id INTEGER,
client_id BIGNUMERIC(38),
item_missing_id NUMERIC(20,0),
item_sid BIGNUMERIC(38),
loc_sid BIGNUMERIC(38),
storage_loc_cd STRING(20),
dwh_cal_dt DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);