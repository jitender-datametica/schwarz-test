CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_dangerous_good_classification_2 (
prod_dang_good_class_cd STRING(5) NOT NULL
OPTIONS(description='The code for the indicating if product is a dangerous good  ( if is  a dangerous good and if additional papers are requried).'),
prod_dang_good_class_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the dangerous good classification in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_dang_good_class_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines dangerous good profile of a product ( if is  a dangerous good and if additional papers are requried).');