/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_PRODUCT_TESTER_ORDER_LINE_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 25. Februar 2025 12:05:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_product_tester_order_line_1 (
cust_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_pos_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The particular position number of an item_1 in an order'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
prod_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product'),
prod_variant_sid BIGNUMERIC OPTIONS(description='Ordered product'),
wh_sid BIGNUMERIC
OPTIONS(description='The unique identifier (sk) for the warehouse from where particular product will be sent'),
cust_paym_method_cd STRING(5) OPTIONS(description='Unique code of the payment method'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
sales_channel_type_cd STRING(5)
OPTIONS(description='The code for the device which was being used to order from the online webshop. Possible values are desktop browser, iOS or Android.'),
cust_order_type_cd STRING(5)
OPTIONS(description='This field contains codes for different credit notes for orders, for example ZRPL for replacement order and ZWSO for webshop sales_1 order and so on.'),
tax_class_cd STRING(5) OPTIONS(description='The code identifying the tax class'),
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country.'),
order_cancel_reason_cd STRING(5)
OPTIONS(description='The code for reason why the customer has cancelled or got been cancelled an order line/product'),
delivery_addr_sid BIGNUMERIC
OPTIONS(description='The unique identifier (sk) for the delivery address_1 where original order was delivered'),
delivery_blocked_reason_cd STRING(5)
OPTIONS(description='The code with the reason why the delivery is blocked for the specific customer order.'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product ordered'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
wh_cd STRING(5) OPTIONS(description='The code for the warehouse from where particular product will be sent'),
cust_order_create_tmsp TIMESTAMP
OPTIONS(description='The timestamp when order was created in source ERP system ( is used in reporting)'),
cust_order_dt DATE OPTIONS(description='The date when order was made ( when customer created the order )'),
cust_order_tm TIME OPTIONS(description='Time when order was made ( when customer created the order )'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
cust_order_perform_dt DATE
OPTIONS(description='The timestamp when the delivery to the customer actually started. This timestamp is relevant from a financial perspective as until then you are not allowed to charge him/her. In case of serveral performance timestamps for a single article within a single order the last date is picked.'),
cust_delivery_tgt_dt DATE
OPTIONS(description='The first date which has been communicated to the customer for the expected delivery'),
delivery_paushal_coupon_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount value gross for paushal delivery cost splitted per every order position in local currency'),
delivery_paushal_coupon_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount value netto for paushal delivery cost splitted per every order position in local currency'),
delivery_paushal_coupon_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='A discount vat value for paushal delivery cost splitted per every order position in local currency'),
delivery_paushal_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='A paushal for delivery costs splitted per every order position in gross and local currency'),
delivery_paushal_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='A paushal for delivery costs splitted per every order position in netto and local currency'),
delivery_paushal_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='The vat value of the paushal delivery costs splitted per every order position in local currency'),
cogs_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs )'),
ekp_unit_price_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Latest EKP (Purchase Price) value in EUR per unit_1'),
gross_margin_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Calculated Net Profit Margin in EUR'),
is_blocked_delivery_fg BOOL
OPTIONS(description='Flag which tells whether a delivery is being blocked currently. e.g. if customer orders with payment type\"Vorauskasse\" then the delivery will only start as soon as the money arrives'),
is_order_cancel_fg BOOL
OPTIONS(description='Flag telling whether the order position has been cancelled. Customers can cancel orders only completely or not at all. Lidl Digital\'s Call Center has the possibility to cancel single positions though. Therefore the position\'s flag within an order has the same value mostly, but can be different values in rare cases.'),
prod_coupon_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='The gross discount value for the (original/listed) product in local currency'),
prod_coupon_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='The net discount value for the (original/listed) product in local currency'),
prod_coupon_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='The discount vat value for the (original/listed) product in local currency'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_1 independent'),
prod_price_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) gross price of a product in local currency'),
prod_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net price of a product in local currency'),
prod_price_vat_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) vat value on price of a product in local currency'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_order_pos_nr, cust_order_sid) NOT ENFORCED
)
OPTIONS(description='The table contains order details from the Product Testing Program and is based on the structure of T_FACT_CUSTOMER_ORDER_LINE. The Products coming from this Program are not listed in t_fact_customer_order_line_1 and are sent free of cost to the customers, hence a separate table is created for the Business analysis.');