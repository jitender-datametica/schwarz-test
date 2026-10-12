CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_legacy_customer_return_line_1 (
wshop_cd STRING(5) OPTIONS(description='The unique code for the Lidl webshop'),
cust_order_return_nr STRING(20) NOT NULL OPTIONS(description='An original return order number'),
cust_order_return_pos_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='A number of an particular position ( product ) in an return order'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
cust_order_pos_nr BIGNUMERIC(38,0) OPTIONS(description='A number of an particular position ( product ) in an order'),
cust_order_return_create_tmsp TIMESTAMP OPTIONS(description='Creation timestamp of the return. '),
cust_order_create_tmsp TIMESTAMP
OPTIONS(description='The date when order was created in source system ( is used in reporting)'),
cust_order_dt DATE OPTIONS(description='The date when order was made'),
cust_order_return_dt DATE OPTIONS(description='The date when return was made'),
cust_nr STRING(20) OPTIONS(description='The customer number from original system'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_1 independent'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product returned'),
curr_cd STRING(5) OPTIONS(description='Currency code'),
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
delivery_paushal_coupon_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount value netto for paushal delivery cost splitted per every order position in local currency'),
delivery_paushal_coupon_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount value gross for paushal delivery cost splitted per every order position in local currency'),
delivery_paushal_coupon_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount vat value for paushal delivery cost splitted per every order position in local currency'),
cogs_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs )'),
dropshipment_order_fg BOOL
OPTIONS(description='In case the material is being sent from the supplier_1 this field will be filled.'),
cust_order_type_cd STRING(5)
OPTIONS(description='The differenciation whether the order will be fulfilled by Lidl (=intercompany) or a supplier_1 directly (= extracompnay).'),
delivery_cust_nr STRING(20) OPTIONS(description='Customer to whom the order was delivered '),
delivery_addr_nr STRING(20) OPTIONS(description='The unique identifier (sk) for the delivery address_1'),
billing_addr_nr STRING(20) OPTIONS(description='The unique identifier (sk) for the billing address_1'),
prod_return_reason_cd STRING(5)
OPTIONS(description='The code for the article return reason on position level  (101, 900, etc)'),
cust_paym_method_cd STRING(5) OPTIONS(description='The code for the payment methods '),
is_legacy_fg BOOL
OPTIONS(description='Technical field used to identify legacy data, for further use as a filter condition'),
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
PRIMARY KEY (cust_order_return_nr, cust_order_return_pos_nr) NOT ENFORCED
) OPTIONS(description='Legacy data contains historical records with details of individual returned items');