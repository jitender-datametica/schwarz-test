CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_sales_target_hourly (
wshop_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the Lidl webshop'),
target_sale_dt DATE NOT NULL OPTIONS(description='A date for which the target is set by headquarter'),
target_sale_hr TIME NOT NULL
OPTIONS(description='A time for which the target is set by headquarter ( distributed by ETL )'),
shop_cat_lvl1_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (sk) for global shop category level 4'),
shop_cat_lvl1_name STRING(100) NOT NULL
OPTIONS(description='The name by which the  global  shop category level 1 is known.'),
curr_cd STRING(5) OPTIONS(description='Currency in which target is set'),
tgt_revenue_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='A target sales amount for a level netto in euro'),
tgt_margin_eur_val BIGNUMERIC(38,5) OPTIONS(description='A target margin amount for a  level  in euro'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
shop_cat_lvl1_cd BIGNUMERIC OPTIONS(description='The code by which the shop category level 1 is known.'),
PRIMARY KEY (wshop_cd, target_sale_dt, target_sale_hr, shop_cat_lvl1_sid, shop_cat_lvl1_name) NOT ENFORCED
) OPTIONS(description='An hourly target sales amount  is set for every product sold in a Lidl webshop');