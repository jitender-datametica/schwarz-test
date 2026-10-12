CREATE OR REPLACE TABLE ldl_dig_production_core.t_dim_shop_category_2 (
shop_cat_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for shop category'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
shop_cat_cd INTEGER OPTIONS(description='The unique code by which the shop category is known'),
shop_cat_name STRING(250) OPTIONS(description='The name by which the shop category is known'),
shop_cat_lvl1_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for shop category level 1'),
shop_cat_lvl2_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for shop category level 2'),
shop_cat_lvl3_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for shop category level 3'),
shop_cat_lvl4_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for shop category level 4'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
shop_cat_lvl1_cd INTEGER OPTIONS(description='The code by which the shop category level 1 is known.'),
shop_cat_lvl2_cd INTEGER OPTIONS(description='The code by which the shop category level 2 is known.'),
shop_cat_lvl3_cd INTEGER OPTIONS(description='The code by which the shop category level 3 is known.'),
shop_cat_lvl4_cd INTEGER OPTIONS(description='The code by which the shop category level 4 is known.'),
PRIMARY KEY (shop_cat_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='This table stores the shop category information');