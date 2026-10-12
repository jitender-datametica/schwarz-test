CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_product_price_conditions_1 (
condition_number_cd STRING(20) NOT NULL,
price_type_cd STRING(20) NOT NULL
OPTIONS(description='Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc'),
curr_cd STRING(5) OPTIONS(description='Currency in which target is set'),
price_val BIGNUMERIC(38,5) OPTIONS(description='Valid price in given currency'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
prod_qty BIGNUMERIC(38,0)
OPTIONS(description='Quantity of products defined in the pricing condition ( fe price is defined per 1000 boxes or 100 boxes in other cases)'),
PRIMARY KEY (condition_number_cd) NOT ENFORCED
)
OPTIONS(description='ETL Support table -  This fact defines the price catalog for lidl internal and customer facing prices.');