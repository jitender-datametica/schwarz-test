CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_sales_promotion_target_2 (
wshop_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the Lidl webshop'),
prod_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
promo_dt DATE NOT NULL OPTIONS(description='Promotion Start Date for offline stores'),
sale_promo_type_cd STRING(25) OPTIONS(description='The way the product gets promoted e.g. website, flyer, etc.'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
promo_price_gross_local_val BIGNUMERIC(38,5) OPTIONS(description='Promotion Selling Price - Gross Value'),
tgt_prod_sale_qty BIGNUMERIC(38,0)
OPTIONS(description='Number of products expected to be sold. Product quantities in stock units (no decimal values).'),
promo_dur_week_cnt BIGNUMERIC OPTIONS(description='How long was the promotion planned to be active (number of weeks)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_2 independent'),
PRIMARY KEY (wshop_cd, prod_sid, promo_dt) NOT ENFORCED
)
OPTIONS(description='Products are being promoted/advertised in different platforms, it is expected to have a certain number of products being sold');