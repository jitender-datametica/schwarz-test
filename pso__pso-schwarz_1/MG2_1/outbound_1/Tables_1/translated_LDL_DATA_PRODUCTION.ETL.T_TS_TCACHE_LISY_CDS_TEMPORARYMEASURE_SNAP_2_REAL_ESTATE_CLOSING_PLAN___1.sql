CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_tcache_lisy_cds_temporarymeasure_snap_2_real_estate_closing_plan___1
(
real_estate_sid INTEGER,
closed_from_dt DATE,
closed_until_dt DATE,
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
dwh_valid_fg BOOL,
closed_bus_days_cnt INTEGER,
dwh_load_id INTEGER,
dwh_node_cd STRING(20),
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg INTEGER
);