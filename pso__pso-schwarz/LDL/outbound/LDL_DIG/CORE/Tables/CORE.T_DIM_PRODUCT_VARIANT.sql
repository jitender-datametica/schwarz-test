/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PRODUCT_VARIANT
   GENERATED FROM POWERDESIGNER ON Freitag, 17. Januar 2025 11:08:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_variant (
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
prod_variant_nr STRING(20) NOT NULL OPTIONS(description='The product variant number'),
prod_variant_name STRING(100) OPTIONS(description='The global product variant name'),
prod_variant_descr STRING(250) OPTIONS(description='The global product variant information in a free text form'),
prod_sid BIGNUMERIC OPTIONS(description='The surrogate key for the main product'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country independent'),
prod_name STRING(100) OPTIONS(description='The centeral name defined for a product by German onlineshop'),
ian_nr STRING(20) OPTIONS(description='Lidl Internal international product number (international article number)'),
main_ean_nr STRING(20) OPTIONS(description='Lidl Internal international product number'),
prod_variant_hist_nr STRING(20)
OPTIONS(description='Old product variant number. This number was used as product number in the past.'),
prod_variant_ian_nr STRING(20)
OPTIONS(description='Lidl Number at variant level. Sometimes it can differ from the product Lidl Number'),
volume_uom_sid BIGNUMERIC OPTIONS(description='Unit of measurement for volume'),
volume_meas BIGNUMERIC(38,5)
OPTIONS(description='Space that the material occupies per unit of volume. The volume refers to the unit specified in the volume unit field'),
weight_uom_sid BIGNUMERIC OPTIONS(description='Unit of measurement for weight'),
weight_meas BIGNUMERIC(38,5) OPTIONS(description='Weight of the material'),
net_weight_meas BIGNUMERIC(38,5) OPTIONS(description='Net weight of the material'),
gross_weight_meas BIGNUMERIC(38,5) OPTIONS(description='Gross weight of the material'),
girth_uom_sid BIGNUMERIC OPTIONS(description='Unit of dimension for girth'),
girth_east_meas BIGNUMERIC(38,5)
OPTIONS(description='Girth size of the material based on east european calculation standard'),
girth_west_meas BIGNUMERIC(38,5)
OPTIONS(description='Girth size of the material based on west european calculation standard'),
length_uom_sid BIGNUMERIC OPTIONS(description='Unit of dimension for length'),
length_meas BIGNUMERIC(38,5) OPTIONS(description='Length of the material'),
mean_length_meas BIGNUMERIC(38,5) OPTIONS(description='Mean size of the material'),
shortest_length_meas BIGNUMERIC(38,5) OPTIONS(description='Shortest size of the material'),
longest_length_meas BIGNUMERIC(38,5) OPTIONS(description='Longest size of the material'),
width_uom_sid BIGNUMERIC OPTIONS(description='Unit of dimension for width'),
width_meas BIGNUMERIC(38,5) OPTIONS(description='Width of the material'),
height_uom_sid BIGNUMERIC OPTIONS(description='Unit of dimension for height'),
height_meas BIGNUMERIC(38,5) OPTIONS(description='Height of the material'),
prod_size_type_cd STRING(5)
OPTIONS(description='The code for the product size type (\'Kleines Kleinteil\',\'Großteil\'	, etc)'),
is_bulky_item_fg BOOL OPTIONS(description='Flag to identify if a product is a bulky item'),
prod_orig_country_cd STRING(5) OPTIONS(description='The country code where the product comes from originally'),
brand_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for brand'),
brand_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product is classified as a Lidl own brand or not'),
prod_assortment_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product is a part of special offer or normal or special assortiment'),
prod_global_status_cd STRING(20) OPTIONS(description='Code that defines the online status of a product '),
prod_food_class_cd STRING(5) OPTIONS(description='The code for the indicating if product is a food or non food'),
palette_capacity_cnt BIGNUMERIC OPTIONS(description='Maximum quantity of items per palette.'),
package_capacity_cnt BIGNUMERIC OPTIONS(description='Maximum quantity of items per package.'),
container_capacity_cnt BIGNUMERIC OPTIONS(description='Maximum quantity of items per container.'),
main_supplier_sid BIGNUMERIC OPTIONS(description='Account number of the main supplier identified for the product.'),
shop_cat_sid BIGNUMERIC OPTIONS(description='Original shop category code'),
shop_cat_name STRING(250) OPTIONS(description='The name by which the original shop category is known'),
shop_cat_lvl4_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for shop category level 4'),
shop_cat_lvl4_name STRING(100)
OPTIONS(description='The name by which the shop category level 4 for global ( German ) product hierarchy is known.'),
shop_cat_lvl3_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for shop category level 3 for global ( German ) product hierarchy'),
shop_cat_lvl3_name STRING(100)
OPTIONS(description='The name by which the shop category level 3 for global ( German ) product hierarchy is known.'),
shop_cat_lvl2_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for shop category level 2 for global ( German ) product hierarchy'),
shop_cat_lvl2_name STRING(100)
OPTIONS(description='The name by which the shop category level 2 is known for global ( German ) product hierarchy'),
shop_cat_lvl1_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for  shop category level 1 for global ( German ) product hierarchy'),
prod_brick_cd STRING(40)
OPTIONS(description='The Brickcode is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. '),
shop_cat_lvl1_name STRING(100)
OPTIONS(description='The name by which the shop category level 1 for global ( German ) product hierarchy is known.'),
prod_variant_src_insert_dt DATE OPTIONS(description='Date when product was inserted in product catalog'),
prod_variant_src_update_dt DATE OPTIONS(description='Date of the last update of product in product catalog'),
is_bundle_header_fg BOOL
OPTIONS(description='Indicates if product represents a bundle header (may not be consistent in order line)'),
prod_variant_import_nr STRING(20)
OPTIONS(description='Commodity Code/Import Code Number for Foreign Trade specific to product variant'),
volume_uom_cd STRING(5) OPTIONS(description='A code for the unit of measure for volume'),
weight_uom_cd STRING(5) OPTIONS(description='A code for the unit of measure for weight'),
girth_uom_cd STRING(5) OPTIONS(description='A code for the unit of measure for girth'),
length_uom_cd STRING(5) OPTIONS(description='A code for the unit of measure for length'),
width_uom_cd STRING(5) OPTIONS(description='A code for the unit of measure for width'),
height_uom_cd STRING(5) OPTIONS(description='A code for the unit of measure for height'),
brand_nr STRING(20) OPTIONS(description='A unique number of brand from the source system'),
shop_cat_lvl4_cd BIGNUMERIC OPTIONS(description='The code by which the shop category level 4 is known.'),
shop_cat_lvl3_cd BIGNUMERIC OPTIONS(description='The code by which the shop category level 3 is known.'),
shop_cat_lvl2_cd BIGNUMERIC OPTIONS(description='The code by which the shop category level 2 is known.'),
shop_cat_lvl1_cd BIGNUMERIC OPTIONS(description='The code by which the shop category level 1 is known.'),
prod_variant_packing_type_cd STRING(20)
OPTIONS(description='This code denotes the type of packaging for the product variant (e.g. box, bag, etc)'),
prod_variant_dang_good_class_cd STRING(5)
OPTIONS(description='The code indicating if product variant is a dangerous good and additional papers are requried. Business marks this information on product variant level.            When not all the product variants are marked as dangerous good , the dangerous goods flag might not be set at the product level.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (prod_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='For a given main product there might be various variants with differ in size, color or flavour');