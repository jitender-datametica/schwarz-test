CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_2lis_02_scl_2_order_record_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
order_record_id NUMERIC(20,0),
sup_sid BIGNUMERIC(38),
loc_sid BIGNUMERIC(38),
order_type_cd STRING(20),
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