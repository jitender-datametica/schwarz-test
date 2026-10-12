CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_food_classification (
prod_food_class_cd STRING(5) NOT NULL
OPTIONS(description='The code for the indicating if product is a food or non food'),
prod_food_class_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the product food classification in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_food_class_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines if product is classified as a food or non food');