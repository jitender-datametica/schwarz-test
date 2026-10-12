CREATE OR REPLACE TABLE ldl_dig_production_core.t_rel_product_additional_number_1 (
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
prod_add_nr_type_cd STRING(5) NOT NULL
OPTIONS(description='The type of of industry and lidl product numbers assigned (gtin, ean_1, producer numbers etc )'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
prod_add_nr STRING(20) NOT NULL OPTIONS(description='A product number ( ean_1 , gtin , producer number , etc)'),
is_main_fg BOOL NOT NULL OPTIONS(description='Flag indicating if number is considered as main at a given point in time'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_1 independent'),
PRIMARY KEY (prod_sid, prod_add_nr_type_cd, dwh_valid_from_tmsp, prod_add_nr) NOT ENFORCED
)
OPTIONS(description='A list of industry and lidl product numbers assigned to a product ( including gtin, ean_1 and producer numbers).');