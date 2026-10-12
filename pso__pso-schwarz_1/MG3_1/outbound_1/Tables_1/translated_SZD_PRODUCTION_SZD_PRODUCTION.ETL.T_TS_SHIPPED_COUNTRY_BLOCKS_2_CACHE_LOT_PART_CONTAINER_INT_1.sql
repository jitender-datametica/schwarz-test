CREATE OR REPLACE TABLE szd_production_etl.t_ts_shipped_country_blocks_2_cache_lot_part_container_int_1 (
lot_part_product_instance_group_sid INTEGER,
container_resource_item_sid INTEGER,
valid_from TIMESTAMP,
valid_to TIMESTAMP,
dwh_valid_fg BOOL,
ship_prod_qty NUMERIC(29,5),
dwh_src_file_name STRING(500),
dwh_src_1_tmsp TIMESTAMP,
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg INTEGER,
dwh_load_id INTEGER
);