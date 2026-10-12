CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_2lis_13_vditm_2_retail_sales_record (
record_id INTEGER,
client_id BIGNUMERIC(38),
retail_sales_record_id NUMERIC(20,0),
curr_sid BIGNUMERIC(38),
curr_cd STRING(20),
invoice_class_cd STRING(20),
invoice_type_cd STRING(20),
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