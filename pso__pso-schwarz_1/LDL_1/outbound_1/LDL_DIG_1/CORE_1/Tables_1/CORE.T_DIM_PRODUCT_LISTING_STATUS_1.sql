CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_listing_status_1 (
prod_listing_status_cd STRING(20) NOT NULL OPTIONS(description='Code that defines the listing status_1 of a product '),
prod_listing_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the listing status_1 of a product '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_listing_status_cd) NOT ENFORCED
) OPTIONS(description='Minor dimension that defines  the listing status_1 of a product ( sellable or non sellable )');