CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_product_variant_internal_code_1 (
prod_variant_internal_cd STRING(20) NOT NULL OPTIONS(description='prod_variant_internal_cd'),
prod_variant_cd STRING(20) OPTIONS(description='prod_variant_cd'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_variant_internal_cd) NOT ENFORCED
) OPTIONS(description='This ETL table to support brickcode .');