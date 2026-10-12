CREATE OR REPLACE TABLE ldl_dig_production_core.t_dim_product_1 (
prod_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
prod_nr STRING(20) NOT NULL
OPTIONS(description='The number for internal onlineshop product, which is country_1 independent'),
prod_name STRING(100) OPTIONS(description='The centeral name defined for a product by German onlineshop'),
prod_descr STRING(250) OPTIONS(description='The product information in a free text form'),
ian_nr STRING(20) OPTIONS(description='Lidl Internal international product number (international article number)'),
prod_brick_cd STRING(40)
OPTIONS(description='The Brickcode is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
shop_cat_lvl4_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for shop category level 4'),
prod_packing_type_cd STRING(20)
OPTIONS(description='Code that defines the general type of packaging for the article (i.e. carton, bag)'),
prod_food_class_cd STRING(5) OPTIONS(description='The code for the indicating if product is a food or non food'),
brand_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product is classified as a Lidl own brand_1 or not'),
shop_cat_lvl4_name STRING(100)
OPTIONS(description='The name by which the shop category level 4 for global ( German ) product hierarchy_1 is known.'),
shop_cat_lvl3_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for shop category level 3 for global ( German ) product hierarchy_1'),
shop_cat_lvl3_name STRING(100)
OPTIONS(description='The name by which the shop category level 3 for global ( German ) product hierarchy_1 is known.'),
shop_cat_lvl2_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for shop category level 2 for global ( German ) product hierarchy_1'),
shop_cat_lvl2_name STRING(100)
OPTIONS(description='The name by which the shop category level 2 is known for global ( German ) product hierarchy_1'),
shop_cat_lvl1_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for  shop category level 1 for global ( German ) product hierarchy_1'),
shop_cat_lvl1_name STRING(100)
OPTIONS(description='The name by which the shop category level 1 for global ( German ) product hierarchy_1 is known.'),
shop_cat_sid INTEGER OPTIONS(description='Original shop category code'),
shop_cat_name STRING(250) OPTIONS(description='The name by which the shop category is known'),
import_nr STRING(20) OPTIONS(description='Commodity Code/Import Code Number for Foreign Trade'),
brand_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for brand_1'),
prod_group_cd STRING(20)
OPTIONS(description='Code of warengruppe - one of the LD classification for the products (DMM165-013, DMM165-014 , etc)'),
prod_storage_cond_cd STRING(5) OPTIONS(description='The code for the indicating if product is a food or non food'),
prod_dang_good_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product is a dangerous good  ( if is  a dangerous good and if additional papers are requried).'),
prod_material_type_cd STRING(5)
OPTIONS(description='The code for the indicating the material type code for a product ( a regular one , a digital one , etc)'),
prod_promo_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product  is a part of a promotion or main assortment.'),
season_nr STRING(20) OPTIONS(description='Unique season ID (Primary Key) in the source system'),
prod_assortment_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product is a part of special offer or normal or special assortiment'),
prod_purch_org_type_cd STRING(5)
OPTIONS(description='The code for the country_1 / Lidl organization which is responsible for the purchasing (negotiation).'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
is_bundle_header_fg BOOL
OPTIONS(description='Indicates if product represents a bundle header (may not be consistent in order line)'),
prod_hist_nr STRING(20) OPTIONS(description='Old product number. This number was used as product number in the past.'),
brand_nr STRING(20) OPTIONS(description='A unique number of brand_1 from the source system'),
shop_cat_lvl4_cd INTEGER OPTIONS(description='The code by which the shop category level 4 is known.'),
shop_cat_lvl3_cd INTEGER OPTIONS(description='The code by which the shop category level 3 is known.'),
shop_cat_lvl2_cd INTEGER OPTIONS(description='The code by which the shop category level 2 is known.'),
shop_cat_lvl1_cd INTEGER OPTIONS(description='The code by which the shop category level 1 is known.'),
prod_subgroup_cd STRING(5)
OPTIONS(description='The product subgroup code describes the category a product is part of. Such as\""baby clothes\"" or\""Workshop - Machines\"" etc.'),
prod_family_cd STRING(20)
OPTIONS(description='The product Family Code represents the lower level of granularity of the Product Categories (sub_prod_group_cd).'),
prod_src_insert_dt DATE OPTIONS(description='Date when product was inserted in product catalog'),
prod_manager_cd STRING(100)
OPTIONS(description='A code indentifiyng the product manager. Util we have actual code value we will be using the name of the manager as a code'),
prod_org_lvl_name STRING(50)
OPTIONS(description='The Organisation level of a product corresponds to the Lidl Digital structure which owns - or is responsible for - these articles (product variants) in the organization.'),
prod_group_ldt_cd STRING(50) OPTIONS(description='The LDT group of products, based on product family or brick code'),
is_wine_spirits_fg BOOL
OPTIONS(description='Flag to identify if the values are belonging to the wine/spirits product gs1 category.'),
subcategory_of_need_cd STRING(50)
OPTIONS(description='The code for main subcategory of Need which the product has been automatically assigned.'),
subcategory_of_need_name STRING(100) OPTIONS(description='The description for subcategory of need product category'),
category_of_need_cd STRING(50)
OPTIONS(description='The code for main Category of Need which the product has been automatically assigned.'),
category_of_need_name STRING(100) OPTIONS(description='The description for category of need product category'),
world_of_need_cd STRING(50)
OPTIONS(description='The code for the main World of Need which the product has been automatically assigned.'),
world_of_need_name STRING(100) OPTIONS(description='The description for world of need product category'),
prod_category_ppe_name STRING(250)
OPTIONS(description='The name of the PPE category which the product has been automatically assigned (Profilierung / Pflicht / Ergänzung).'),
PRIMARY KEY (prod_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The product describes goods and services which are offered by the enterprise. In case of a retailer, these are the goods the company trades with. The term product is not limited to the current assortment of goods and services but may also include articles of competitors or articles which are currently not in the assortment');