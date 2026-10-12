CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_price_gld_1 (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
price_type_cd STRING(20) NOT NULL
OPTIONS(description='Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc'),
price_group_cd STRING(20) OPTIONS(description='Code of pricing group - internal or customer facing'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
wh_cd STRING(5) OPTIONS(description='A short  unique code for warehouse'),
curr_cd STRING(5) OPTIONS(description='Currency in which price is set'),
price_val BIGNUMERIC(38,5) OPTIONS(description='Valid price in given currency'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (wh_sid, prod_variant_sid, price_type_cd, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='ETL Support table - A fact for prices on warehouse level (GLD)');