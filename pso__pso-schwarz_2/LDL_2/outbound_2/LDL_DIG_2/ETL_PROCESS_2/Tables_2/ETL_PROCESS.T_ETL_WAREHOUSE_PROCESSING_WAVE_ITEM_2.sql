CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_processing_wave_item_2 (
wh_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
wave_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wave Identifier'),
rdoc_id STRING(64) NOT NULL OPTIONS(description='Identifier'),
ritm_id STRING(64) NOT NULL OPTIONS(description='Identifier'),
wave_error STRING(2) OPTIONS(description='wave error'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
wh_order_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (sk) for warehouse order'),
wh_order_pos_nr BIGNUMERIC(38,0) OPTIONS(description='The particular position number of a position in an order'),
max_wave_qty BIGNUMERIC(38,5) OPTIONS(description='The maximum wave item_2 quantity'),
PRIMARY KEY (wh_sid, wave_id, rdoc_id, ritm_id) NOT ENFORCED
) OPTIONS(description='ETL  table to support T_FACT_WAREHOUSE_PROCESSING_2');