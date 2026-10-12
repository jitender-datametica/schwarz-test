/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_PRODUCT_VARIANT_REGIONAL_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 27. Dezember 2023 14:19:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_product_variant_regional_1 (
wshop_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the Lidl webshop'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
prod_variant_nr STRING(20) OPTIONS(description='The original product variant number'),
reg_prod_variant_name STRING(100)
OPTIONS(description='The name by which the product variant is known  in particular webshop'),
reg_prod_variant_descr STRING(250)
OPTIONS(description='Information about product variant in a free text form ( webshop specific )'),
prod_sid BIGNUMERIC OPTIONS(description='The surrogate key for the main product '),
prod_nr STRING(20) OPTIONS(description='The original product number'),
reg_prod_name STRING(100) OPTIONS(description='The name by which the main product is known in particular webshop'),
prod_tgt_delivery_time BIGNUMERIC
OPTIONS(description='This field comes from the VLT-Tool and tells how much time is expected for the delivery for a specific product variant. The value is country_1 dependant.'),
tax_class_cd STRING(5) OPTIONS(description='The code identifying the tax class'),
material_pos_type_cd STRING(5)
OPTIONS(description='The code for the process type a product can be assigned to (e.g NORM, BANS).'),
delivery_src_type_cd STRING(5)
OPTIONS(description='The code for source location_1 of product from where it is delivered i.e. from supplier_1 or warehouse directly'),
pack_size_handle_group_cd STRING(5)
OPTIONS(description='A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it -\' 1 person\'  ,\'2 persons\' etc'),
prod_size_handle_group_cd STRING(10)
OPTIONS(description='Product size classification defined by Controlling/PM. It divides the product size in types based on their dimensions (P_KT,P_GT,P_2MH, P_Sonst).            Necessary for evaluation of variable and fixed costs based on the size group.'),
prod_reg_catalog_update_dt DATE
OPTIONS(description='Date of the last update of product in product catalog in particular country_1'),
prod_reg_catalog_insert_dt DATE
OPTIONS(description='Date when product was inserted in product catalog in particular country_1'),
first_online_dt DATE
OPTIONS(description='Date of the first time the product went online in store on product_variant + country_1 level'),
shop_cat_sid BIGNUMERIC OPTIONS(description='The original shop category code ( may be lower than level 4 )'),
shop_cat_name STRING(250) OPTIONS(description='The name by which the original shop category is known.'),
shop_cat_lvl4_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for shop category level 4'),
shop_cat_lvl4_name STRING(100) OPTIONS(description='The name by which the shop category level 4 is known.'),
shop_cat_lvl3_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for shop category level 3'),
shop_cat_lvl3_name STRING(100) OPTIONS(description='The name by which the shop category level 3 is known.'),
shop_cat_lvl2_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for shop category level 2'),
shop_cat_lvl2_name STRING(100) OPTIONS(description='The name by which the shop category level 2 is known.'),
shop_cat_lvl1_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for shop category level 1'),
shop_cat_lvl1_name STRING(100) OPTIONS(description='The name by which the shop category level 1 is known.'),
prod_online_status_cd STRING(20) OPTIONS(description='Code that defines the online status_1 of a product '),
prod_listing_status_cd STRING(20) OPTIONS(description='Code that defines the listing status_1 of a product '),
shop_cat_lvl4_cd BIGNUMERIC OPTIONS(description='The code by which the shop category level 4 is known.'),
shop_cat_lvl3_cd BIGNUMERIC OPTIONS(description='The code by which the shop category level 3 is known.'),
shop_cat_lvl2_cd BIGNUMERIC OPTIONS(description='The code by which the shop category level 2 is known.'),
shop_cat_lvl1_cd BIGNUMERIC OPTIONS(description='The code by which the shop category level 1 is known.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (prod_variant_sid, dwh_valid_from_tmsp, wshop_cd) NOT ENFORCED
) OPTIONS(description='For a product variant, attributes can be different in different countries');