CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_category_of_need_2 (
category_of_need_cd STRING(50) NOT NULL
OPTIONS(description='The code for main Category of Need which the product has been automatically assigned.'),
category_of_need_name STRING(100) OPTIONS(description='The description for category of need product category'),
world_of_need_cd STRING(50)
OPTIONS(description='The code for the main World of Need which the product has been automatically assigned.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (category_of_need_cd) NOT ENFORCED
)
OPTIONS(description='The World of Needs categorization system groups products into six broad categories to simplify and organize the vast array of products. A Category of Need represents a middle level of this product categorization (examples are Men\'s Clothing, Toys, and Fitness goods).');