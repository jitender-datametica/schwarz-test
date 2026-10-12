CREATE OR REPLACE TABLE ldl_dig_production_core.t_rel_product_regional_2 (
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
wshop_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the Lidl webshop'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product'),
reg_prod_name STRING(100) OPTIONS(description='The product name that is defined per country_2'),
reg_prod_descr STRING(250) OPTIONS(description='The regional product information in a free text form'),
delivery_src_type_cd STRING(5)
OPTIONS(description='The code for source location_2 of product from where it is delivered i.e. from supplier_2 or warehouse directly'),
shop_cat_lvl4_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for shop category level 4'),
shop_cat_lvl4_name STRING(100) OPTIONS(description='The name by which the shop category level 4 is known.'),
shop_cat_lvl3_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for shop category level 3'),
shop_cat_lvl3_name STRING(100) OPTIONS(description='The name by which the shop category level 3 is known.'),
shop_cat_lvl2_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for shop category level 2'),
shop_cat_lvl2_name STRING(100) OPTIONS(description='The name by which the shop category level 2 is known.'),
shop_cat_lvl1_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for shop category level 1'),
shop_cat_lvl1_name STRING(100) OPTIONS(description='The name by which the shop category level 1 is known.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
shop_cat_sid INTEGER OPTIONS(description='The original shop category code'),
shop_cat_name STRING(250) OPTIONS(description='The name by which the original shop category is known.'),
material_pos_type_cd STRING(5)
OPTIONS(description='The code for the process type a product can be assigned to (e.g NORM, BANS).'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
shop_cat_lvl4_cd INTEGER OPTIONS(description='The code by which the shop category level 4 is known.'),
shop_cat_lvl3_cd INTEGER OPTIONS(description='The code by which the shop category level 3 is known.'),
shop_cat_lvl2_cd INTEGER OPTIONS(description='The code by which the shop category level 2 is known.'),
shop_cat_lvl1_cd INTEGER OPTIONS(description='The code by which the shop category level 1 is known.'),
tax_class_cd STRING(5) OPTIONS(description='The code identifying the tax class'),
prod_family_cd STRING(20)
OPTIONS(description='The code representing the lower level of granularity of the Product Categories (prod_subgroup_cd).'),
reg_prod_manager_cd STRING(10) OPTIONS(description='A code indentifiyng the regional product manager.'),
PRIMARY KEY (prod_sid, dwh_valid_from_tmsp, wshop_cd) NOT ENFORCED
) OPTIONS(description='For a product, attributes can be different in different countries');