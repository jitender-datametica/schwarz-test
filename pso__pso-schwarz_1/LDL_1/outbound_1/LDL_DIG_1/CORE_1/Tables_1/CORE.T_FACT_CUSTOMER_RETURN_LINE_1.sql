CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_customer_return_line_1 (
cust_order_return_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for return of customer order'),
cust_order_return_pos_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='A number of an particular position ( product ) in an return order'),
wshop_cd STRING(5) OPTIONS(description='The unique code for the Lidl webshop'),
cust_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_pos_nr BIGNUMERIC(38,0) OPTIONS(description='The particular position number of an item_1 in an order'),
prod_variant_sid BIGNUMERIC OPTIONS(description='Returned product'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
cust_order_type_cd STRING(5)
OPTIONS(description='This field contains codes for different credit notes for returns, for example ZREU for returns in Lidl\'s warehouse and ZRET for returns in third party\'s warehouse and so on.'),
delivery_addr_sid BIGNUMERIC
OPTIONS(description='The unique identifier (sk) for the delivery address_1 where original order was delivered'),
billing_addr_sid BIGNUMERIC OPTIONS(description='The unique identifier (sk) for the billing address_1'),
prod_return_reason_cd STRING(5)
OPTIONS(description='The code for the article return reason on position level  (101, 900, etc)'),
order_return_reason_cd STRING(5)
OPTIONS(description='The code for the reason code on return document level .( 401 - Leeres Paket, 104 - Artikel_1 unvollständig , etc)'),
prod_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product'),
cust_paym_method_cd STRING(5) OPTIONS(description='Unique code of the payment method'),
return_wh_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for the warehouse handling the return.'),
cust_order_return_nr STRING(20) NOT NULL OPTIONS(description='An original return order number'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
cust_order_return_create_tmsp TIMESTAMP OPTIONS(description='Creation timestamp of the return. '),
cust_order_create_tmsp TIMESTAMP
OPTIONS(description='The timestamp when order was created in source system ( is used in reporting)'),
cust_order_dt DATE OPTIONS(description='The date when order was made'),
cust_order_return_dt DATE OPTIONS(description='The date when return was made'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product returned'),
return_paym_to_cust_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the payment is transferred to the customer in case of a returned item.'),
prod_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original ( listed ) price of a returned product netto in local currency'),
prod_price_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original ( listed ) price of a  returned product gross in local currency'),
prod_price_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original ( listed ) vat  on price of a returned  product in local currency'),
prod_coupon_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='An amount of discount coupon for a  returned product net in local currency'),
prod_coupon_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='An amount of discount coupon for a  returned product gross in local currency'),
prod_coupon_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='A vat for amount of discount coupon for a returned product in local currency'),
delivery_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='A returned article specific delivery costs netto in local currency. This cost is optional and mostly article dependent. An example is a fridge which has additional delivery costs.'),
delivery_cost_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='A returned article  specific delivery costs gross in local currency. This cost is optional and mostly article dependent. An example is a fridge which has additional delivery costs.'),
delivery_cost_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='A returned article  specific delivery vat value in local currency. This tax value is optional and mostly article dependent. An example is a fridge which has additional delivery costs for which taxes might have to be paid.'),
delivery_coupon_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount value netto for  returned article specific delivery costs in local currency.'),
delivery_coupon_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount value gross for  returned article specific delivery costs in local currency.'),
delivery_coupon_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount vat value for  returned article specific delivery costs in local currency.'),
delivery_paushal_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='A paushal for delivery costs splitted per every order position in gross and local currency'),
delivery_paushal_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='A paushal for delivery costs splitted per every order position in netto and local currency'),
delivery_paushal_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='The vat value of the paushal delivery costs splitted per every order position in local currency'),
add_delivery_paushal_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Additional net delivery fee/paushal for special destinations (Distribution Zones),  splitted per every order position in local currency.'),
add_delivery_paushal_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Additional gross delivery fee/paushal for special destinations (Distribution Zones),  splitted per every order position in local currency'),
add_delivery_paushal_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Additional vat on delivery fee/paushal for special destinations (Distribution Zones),  splitted per every order position in local currency'),
delivery_paushal_coupon_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount value netto for paushal delivery cost splitted per every order position in local currency'),
delivery_paushal_coupon_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount value gross for paushal delivery cost splitted per every order position in local currency'),
delivery_paushal_coupon_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount vat value for paushal delivery cost splitted per every order position in local currency'),
ivp_price_net_local_val BIGNUMERIC(38,5) OPTIONS(description='Internal invoice price in local currency  netto'),
gld_price_net_local_val BIGNUMERIC(38,5) OPTIONS(description='Moving average price in local currency netto'),
gld_unit_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The gld unit_1 price in sales_1 order line in euros for internal margin calculations'),
ivp_original_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Internal invoice price in local currency  netto ( may be null and is used in calculation of ivp_price_net_local_val )'),
ivp_unit_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='This field is a derived one based on ivp_original_unit_price_net_eur_val and gld_unit_price_net_eur_val'),
ivp_original_unit_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The ivp original unit_1 prices in sales_1 order line in euros for internal margin calculations'),
cogs_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs )'),
sellback_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='A sellback value net for returned article specific in local currency. Amount which is discounted from the product internal price after it is returned, depending on its condition (whether it is damaged or not). '),
add_services_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Additional services vat value of a returned article in local currency. This cost is optional and mostly article dependent.'),
add_services_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Additional services gross value of a returned article in local currency. This cost is optional and mostly article dependent.'),
add_services_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Additional services net value of a returned article in local currency. This cost is optional and mostly article dependent.'),
dropshipment_order_fg BOOL
OPTIONS(description='In case the material is being sent from the supplier_1 this field will be filled.'),
return_wh_cd STRING(5) OPTIONS(description='A short  unique code for warehouse handling the return.'),
is_credit_note_issued_fg BOOL OPTIONS(description='Flag that is set if credit note was isssued for a return'),
is_legacy_fg BOOL
OPTIONS(description='Technical field used to identify legacy data (from Qlik legacy systems vs_1 generic data flows), for further use as a filter condition'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_1 independent'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
prod_condition_cd STRING(20)
OPTIONS(description='The condition code of the product. (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping)'),
cogs_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Cost of Goods Sold (short: CoGs) in EUR. Calculation of exchange rate is done in SAP.'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
dist_channel_type_cd STRING(5)
OPTIONS(description='A  type of distribution channel ( Wshop for LD Webshop , IC for Intercompany)'),
dist_country_cd STRING(5)
OPTIONS(description='The unique code for a country_1 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
dist_zone_cd STRING(5) OPTIONS(description='The unique code for a distribution zone ( f.e. BAL , CAN, etc)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_order_return_sid, cust_order_return_pos_nr) NOT ENFORCED
)
OPTIONS(description='The returns for an  order placed from a customer within the onlineshop to receive the wanted items, which he actually he payed for. Table contain information about details of individual returned items');