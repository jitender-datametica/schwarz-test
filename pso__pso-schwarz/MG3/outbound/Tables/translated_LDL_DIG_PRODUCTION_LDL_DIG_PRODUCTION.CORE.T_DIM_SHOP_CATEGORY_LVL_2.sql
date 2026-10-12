CREATE OR REPLACE TABLE ldl_dig_production_core.t_dim_shop_category_lvl_2 (
shop_cat_lvl2_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for shop category level 2'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
shop_cat_lvl2_cd INTEGER OPTIONS(description='The code by which the shop category level 2 is known.'),
shop_cat_lvl2_name STRING(100) OPTIONS(description='The name by which the shop category level 2 is known.'),
shop_cat_lvl1_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for shop category level 1'),
shop_cat_lvl1_cd INTEGER OPTIONS(description='The code by which the shop category level 1 is known.'),
shop_cat_lvl1_name STRING(100) OPTIONS(description='The name by which the shop category level 1 is known.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (shop_cat_lvl2_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='Global shop category - second level of product hierarchy ');