/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SALES_TARGET
   GENERATED FROM POWERDESIGNER ON Mittwoch, 21. Februar 2024 17:30:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_sales_target (
wshop_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the Lidl webshop'),
target_sale_dt DATE NOT NULL OPTIONS(description='A date for which the target is set by headquarter'),
delivery_src_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for source location of product from where it is delivered i.e. from supplier or warehouse directly'),
prod_assortment_class_cd STRING(5) NOT NULL
OPTIONS(description='The code for the indicating if product is a part of special offer or normal or special assortiment'),
prod_food_class_cd STRING(5) NOT NULL
OPTIONS(description='The code for the indicating if product is a food or non food'),
brand_class_cd STRING(5) NOT NULL
OPTIONS(description='The code for the indicating if product is classified as a Lidl own brand or not'),
shop_cat_lvl1_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (sk) for global shop category level 1'),
shop_cat_lvl1_name STRING(100) OPTIONS(description='The name by which the  global  shop category level 1 is known.'),
tgt_prod_sale_qty BIGNUMERIC(38,0)
OPTIONS(description='Number of products expected to be sold. Product quantities in stock units (no decimal values).'),
tgt_revenue_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='A target sales amount for a level netto in euro'),
tgt_margin_eur_val BIGNUMERIC(38,5) OPTIONS(description='A target margin amount for a  level  in euro'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
prod_org_lvl_name STRING(50)
OPTIONS(description='The Organisation level of a product corresponds to the Lidl Digital structure which owns - or is responsible for - these articles (product variants) in the organization.'),
shop_cat_lvl1_cd BIGNUMERIC OPTIONS(description='The code by which the shop category level 1 is known.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, target_sale_dt, delivery_src_type_cd, prod_assortment_class_cd, prod_food_class_cd,
 brand_class_cd, shop_cat_lvl1_sid) NOT ENFORCED
) OPTIONS(description='An daily target sales amount  is set for every product sold in a Lidl webshop');