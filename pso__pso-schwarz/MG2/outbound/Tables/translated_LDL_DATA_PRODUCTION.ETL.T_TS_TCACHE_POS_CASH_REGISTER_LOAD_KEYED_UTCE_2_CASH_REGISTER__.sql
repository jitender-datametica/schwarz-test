CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_tcache_pos_cash_register_load_keyed_utce_2_cash_register__ (
cash_register_sid BIGNUMERIC(38,0),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
dwh_valid_fg BOOL,
cash_register_nr BIGNUMERIC(38,0),
real_estate_sid BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0),
dwh_node_cd STRING(20),
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg BIGNUMERIC(38,0)
);