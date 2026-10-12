CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_legacy_customer_order_line_1 (
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country.'),
cust_order_create_tmsp TIMESTAMP
OPTIONS(description='The date when order was created in source system ( is used in reporting)'),
cust_order_dt DATE OPTIONS(description='The date when order was made'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_1 independent'),
cust_nr STRING(20) OPTIONS(description='A customer number from original system'),
cust_order_nr STRING(20) NOT NULL OPTIONS(description='The order number of the source system'),
cust_order_pos_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The particular position number of an item_1 in an order'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product ordered'),
is_bundle_header_fg BOOL
OPTIONS(description='Indicates if position represents a bundle header ( null in all the other cases)'),
bundle_header_pos_nr BIGNUMERIC(38,0)
OPTIONS(description='In case of a line being a composition part of the bundle-header (see bundle header code field), it can be allocated with this field to its header item_1'),
curr_cd STRING(5) OPTIONS(description='Currency code in which order has been payed'),
prod_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net price of a product in local currency'),
prod_price_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) gross price of a product in local currency'),
prod_price_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) vat value on price of a product in local currency'),
prod_coupon_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='The net discount value for the (original/listed) product in local currency'),
prod_coupon_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='The gross discount value for the (original/listed) product in local currency'),
prod_coupon_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='The discount vat value for the (original/listed) product in local currency'),
delivery_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Article specific net delivery cost in local currency. This cost is optional and mostly article dependent. An example is a fridge which has additional delivery costs'),
delivery_cost_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Article specific gross delivery cost in local currency. This cost is optional and mostly article dependent. An example is a fridge which has additional delivery costs.'),
delivery_cost_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Article specific delivery vat value in local currency. This tax value is optional and mostly article dependent. An example is a fridge which has additional delivery costs for which taxes might have to be paid'),
delivery_coupon_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='The net discount value for article specific delivery costs in local currency.'),
delivery_coupon_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='The gross discount value for article specific delivery costs in local currency.'),
delivery_coupon_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='The discount vat value for article specific delivery costs in local currency'),
delivery_paushal_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='A paushal for delivery costs splitted per every order position in netto and local currency'),
delivery_paushal_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='A paushal for delivery costs splitted per every order position in gross and local currency'),
delivery_paushal_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='The vat value of the paushal delivery costs splitted per every order position in local currency'),
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
tax_class_cd STRING(5) OPTIONS(description='The code identifying the tax class'),
delivery_cust_nr STRING(20) OPTIONS(description='A customer number from original system'),
delivery_addr_nr STRING(100) OPTIONS(description='The address_1 number in source system'),
billing_addr_nr STRING(100) OPTIONS(description='The address_1 number in source system'),
is_blocked_delivery_fg BOOL
OPTIONS(description='Flag which tells whether a delivery is being blocked currently. e.g. if customer orders with payment type\"Vorauskasse\" then the delivery will only start as soon as the money arrives'),
delivery_blocked_reason_cd STRING(5)
OPTIONS(description='The code with the reason why the delivery is blocked for the specific customer order.'),
is_order_cancel_fg BOOL
OPTIONS(description='Flag telling whether the order has been cancelled by the customer or Lidl Digital'),
order_cancel_status_cd STRING(5) OPTIONS(description='The code for the status_1 of cancellation'),
cust_paym_method_cd STRING(5) OPTIONS(description='The code for the payment methods'),
sales_channel_type_cd STRING(5)
OPTIONS(description='The code for the device which was being used to order from the online webshop. Possible values are desktop browser, iOS or Android.'),
order_cancel_reason_cd STRING(5)
OPTIONS(description='The code for reason why the customer has cancelled or got been cancelled an order line/product'),
cust_order_type_cd STRING(5)
OPTIONS(description='The differenciation whether the order will be fulfilled by Lidl (=intercompany) or a supplier_1 directly (= extracompnay)'),
cust_order_perform_dt DATE
OPTIONS(description='The timestamp when the delivery to the customer actually started. This timestamp is relevant from a financial perspective as until then you are not allowed to charge him/her. In case of serveral performance timestamps for a single article within a single order the last date is picked.'),
cust_delivery_tgt_dt DATE
OPTIONS(description='The first date which has been communicated to the customer until when the shipment is meant to arrive'),
wh_cd STRING(5) OPTIONS(description='The code for the warehouse from where particular product will be sent'),
prod_assortment_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product variant is a part of special offer or normal or special assortiment'),
sales_segment_type_cd STRING(20) OPTIONS(description='The sales_1 channel name'),
order_reason_cd STRING(5) OPTIONS(description='Order reason code on order document level ( 008 guter Service ,etc)'),
delivery_src_type_cd STRING(5)
OPTIONS(description='The code for source location_1 of product from where it is delivered i.e. from supplier_1 or warehouse directly'),
dropshipment_order_fg BOOL
OPTIONS(description='In case the material is being sent from the supplier_1 this field will be filled.'),
is_part_of_bundle_header_cnt_fg BOOL
OPTIONS(description='Reporting relevant - if report uses the bundle header count use this flag. Set as\'true\' for bundle header and non-bundle item_1 and\'false\' for bundle position item_1 '),
is_part_of_bundle_pos_cnt_fg BOOL
OPTIONS(description='Reporting relevant - if report uses the bundle header count use this flag. Set as\'true\' for bundle position and non-bundle item_1 and\'false\' for bundle header item_1 '),
initial_cust_order_nr STRING(20) OPTIONS(description='The initial order number of the legacy source system (SEP)'),
is_legacy_fg BOOL
OPTIONS(description='Technical field used to identify legacy data, for further use as a filter condition'),
was_not_migrated_fg BOOL OPTIONS(description='In case the order was not migrated to RJI during the 2021 SAP Migration'),
exchange_rate NUMERIC(9,5) OPTIONS(description='Currency exchange rate from our legacy systems (SEP, Qlikview)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
lead_src_log_sys_cd STRING(5) OPTIONS(description='SAP MANDT code associated with the source system'),
lead_src_name STRING(100) OPTIONS(description='Source system from which the record was fetched (RJI or SEP)'),
PRIMARY KEY (cust_order_nr, cust_order_pos_nr) NOT ENFORCED
) OPTIONS(description='Legacy data contains historical records with details of individual ordered items');