CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_2lis_03_bf_2_item_movement_record_2 (
record_id INTEGER,
client_id BIGNUMERIC(38),
item_movement_record_year BIGNUMERIC(38),
item_movement_record_id NUMERIC(20,0),
doc_dt DATE,
event_type_cd STRING(20),
acct_rec_entry_tmsp DATETIME,
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