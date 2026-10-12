CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_pallet_type_2_dim_pallet_type__ (
pallet_type_cd STRING(20),
pallet_type_descr STRING(250),
pallet_type_descr_de STRING(250),
pallet_type_descr_en STRING(250),
pallet_space_factor NUMERIC(29,5),
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