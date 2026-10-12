CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_product_main_category_of_need (
prod_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
world_of_need_cd STRING(20)
OPTIONS(description='The code for the main World of Need which the product has been automatically assigned.'),
world_of_need_name STRING(250)
OPTIONS(description='The name of the main World of Need which the product has been automatically assigned.'),
category_of_need_cd STRING(20)
OPTIONS(description='The code for the main Category of Need which the product has been automatically assigned.'),
category_of_need_name STRING(250)
OPTIONS(description='The name of the main Category of Need which the product has been automatically assigned.'),
subcategory_of_need_cd STRING(20)
OPTIONS(description='The code for the main Subcategory of Need (if any) which the product has been automatically assigned.'),
subcategory_of_need_name STRING(250)
OPTIONS(description='The name of the main Subcategory of Need (if any) which the product has been automatically assigned.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_sid) NOT ENFORCED
)
OPTIONS(description='Cleaned table, showing only the main relationship between product/category_of_needs                          Source: Progress (the system behind the online shop).');