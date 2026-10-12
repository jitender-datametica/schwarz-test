CREATE OR REPLACE TABLE ldl_dig_production_core.t_dim_product_subcategory_of_need_2 (
subcategory_of_need_cd STRING(50) NOT NULL
OPTIONS(description='The code for main subcategory of Need which the product has been automatically assigned.'),
subcategory_of_need_name STRING(100) OPTIONS(description='The description for subcategory of need product category'),
category_of_need_cd STRING(50)
OPTIONS(description='The code for main Category of Need which the product has been automatically assigned.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (subcategory_of_need_cd) NOT ENFORCED
)
OPTIONS(description='The World of Needs categorization system groups products into six broad categories to simplify and organize the vast array of products. A Subcategory of Need represents a lowest level of this product categorization (example: Redwine).');