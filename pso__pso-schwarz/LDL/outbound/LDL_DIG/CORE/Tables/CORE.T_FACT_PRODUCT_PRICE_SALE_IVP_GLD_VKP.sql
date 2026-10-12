CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_product_price_sale_ivp_gld_vkp (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
cal_dt DATE NOT NULL OPTIONS(description='Reporting date'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
curr_cd STRING(5) OPTIONS(description='Currency in which target is set'),
gld_price_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Moving average price in euro netto'),
gld_price_net_local_val BIGNUMERIC(38,5) OPTIONS(description='Moving average price in local currency netto'),
ivp_price_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Internal invoice price in euro netto'),
ivp_price_net_local_val BIGNUMERIC(38,5) OPTIONS(description='Internal invoice price in local currency  netto'),
vkp_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='VKP - Original (listed) net price of a product in local currency'),
vkp_price_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='VKP - Original (listed) net price of a product in eur'),
vkp_price_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='VKP - Original (listed) gross price of a product in local currency'),
vkp_price_gross_eur_val BIGNUMERIC(38,5) OPTIONS(description='VKP - Original (listed) gross price of a product in eur'),
first_valid_price_fg BOOL
OPTIONS(description='Flag indicatiing if this is the first day for which we have valid sale prices for the given product in the given webshop'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
prod_variant_nr STRING(20) OPTIONS(description='The original product variant number'),
PRIMARY KEY (wshop_cd, prod_variant_sid, cal_dt) NOT ENFORCED
)
OPTIONS(description='A fact for GSL , IVP and VKP prices taken from sales fact, Fact contains a price taken from latest sale up to end of the day ');