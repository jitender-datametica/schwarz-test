CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_storage_condition_1 (
prod_storage_cond_cd STRING(5) NOT NULL
OPTIONS(description='The code for the indicating the storage conditions for a product  (Z1, 01, etc)'),
prod_storage_cond_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the storage conditions in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_storage_cond_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the storage conditions for a product  ');