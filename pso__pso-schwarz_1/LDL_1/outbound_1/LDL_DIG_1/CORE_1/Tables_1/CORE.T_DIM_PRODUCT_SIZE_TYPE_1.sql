CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_size_type_1 (
prod_size_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for the product size type (\'Kleines Kleinteil\',\'Großteil\'\t, etc)'),
prod_size_type_group_cd STRING(5)
OPTIONS(description='A code for product size  classification grouped in the bigger buckets -\'Kleinteil\',\'Großteil\', etc'),
prod_size_type_descr STRING(250)
OPTIONS(description='A textual description for the  product  size type  in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_size_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension for product size classification as defined by Lidl, based on the product\'s dimensions (length, width, height) -\'Kleines Kleinteil\',\'Großteil\', etc');