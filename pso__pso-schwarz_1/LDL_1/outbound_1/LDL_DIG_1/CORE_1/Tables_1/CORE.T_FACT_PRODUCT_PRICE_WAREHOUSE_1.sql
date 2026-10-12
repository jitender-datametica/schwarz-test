CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_product_price_warehouse_1 (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
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
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
is_substitution_price_fg BOOL
OPTIONS(description='The calculated field to indicate substitution / replaced values (GLD -- EKP)'),
PRIMARY KEY (wh_sid, prod_variant_sid, price_type_cd, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='A fact for prices on warehouse level (GLD)');