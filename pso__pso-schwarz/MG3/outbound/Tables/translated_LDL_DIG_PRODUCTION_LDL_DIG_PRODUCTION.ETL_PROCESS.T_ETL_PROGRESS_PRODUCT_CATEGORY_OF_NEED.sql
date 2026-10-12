CREATE OR REPLACE TABLE ldl_dig_production_etl_process.t_etl_progress_product_category_of_need (
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country independent.'),
meta_timestamp TIMESTAMP NOT NULL
OPTIONS(description='The meta timestamp indicated in source data.'),
meta_language STRING(20) NOT NULL OPTIONS(description='The meta language indicated in source data.'),
lowest_need_cat_lvl_cd STRING(20) NOT NULL
OPTIONS(description='The code for the lowest level of category of need used for classifying the product on the online shop.'),
is_main_fg BOOL
OPTIONS(description='A flag indicating that the category of needs indicated for this product is the main one.'),
lowest_need_cat_lvl_name STRING(250)
OPTIONS(description='The name for the lowest level of category of need used for classifying the product on the online shop.'),
lowest_need_cat_parent_lvl_cd STRING(20)
OPTIONS(description='The code for the parent category of the lowest hieararchy of need used for classifying the product on the online shop.'),
super_cat_child_lvl_cd STRING(20) NOT NULL
OPTIONS(description='The code for the child supercategory in the hierarchy of needs which has been defined for this product.'),
super_cat_child_lvl_name STRING(250)
OPTIONS(description='The name for the child supercategory in the hierarchy of needs which has been defined for this product.'),
super_cat_parent_lvl_cd STRING(20)
OPTIONS(description='The code for the parent supercategory in the hierarchy of needs which has been defined for this product.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_sid, meta_timestamp, meta_language, lowest_need_cat_lvl_cd, super_cat_child_lvl_cd) NOT ENFORCED
)
OPTIONS(description='World of Needs is a categorization for products, The goal is to divide products in only 6 big categories (+ subcategories). This table is a technical reproduction from the source, built in a parent_child way to get all the possible relationships between products/categories/subcategories.\n\n             Source: Progress (the system behind the online shop).\n             ');