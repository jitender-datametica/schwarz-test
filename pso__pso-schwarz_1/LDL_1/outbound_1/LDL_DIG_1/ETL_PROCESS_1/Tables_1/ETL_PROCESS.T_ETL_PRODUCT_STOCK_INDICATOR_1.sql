CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_product_stock_indicator_1 (
prod_variant_sid BIGNUMERIC NOT NULL OPTIONS(description='Theunique identifier(surrogate key) for product variant'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
product_ewm_mat_id STRING(50) OPTIONS(description='The ewm material identifier'),
stock_placement_cd STRING(10) OPTIONS(description='The code for stock palcement'),
stock_removal_cd STRING(10) OPTIONS(description='The code for stock removal'),
wh_sid BIGNUMERIC OPTIONS(description='The unique identifier for the warehouse'),
wh_cd STRING(5) OPTIONS(description='A short  unique code for warehouse'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_variant_sid) NOT ENFORCED
) OPTIONS(description='The etl support table to connect EWM mapping data to retail t_fact_goods_movement_1');