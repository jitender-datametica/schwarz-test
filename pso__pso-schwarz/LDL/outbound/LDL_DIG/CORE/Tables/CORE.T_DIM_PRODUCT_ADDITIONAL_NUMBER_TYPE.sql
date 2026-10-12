CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_additional_number_type (
prod_add_nr_type_cd STRING(5) NOT NULL
OPTIONS(description='The type of of industry and lidl product numbers assigned (gtin, ean, producer numbers etc )'),
prod_add_nr_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description of  lidl product assortment number in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_add_nr_type_cd) NOT ENFORCED
)
OPTIONS(description='A list of industry and lidl product numbers assigned to a product and/or product variant ( including gtin, ean and producer numbers).');