CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_2lis_03_bf_2_item_movement_record (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
lis_03_bf_mblnr STRING(20),
lis_03_bf_mjahr INTEGER,
item_movement_record_year BIGNUMERIC(38),
item_movement_record_id NUMERIC(20,0),
doc_dt DATE,
event_type_cd STRING(20),
acct_rec_entry_tmsp DATETIME,
dwh_cal_dt DATE,
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);