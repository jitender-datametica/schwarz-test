/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_INTERCOMPANY_ORDER_LINE
   GENERATED FROM POWERDESIGNER ON Montag, 31. Juli 2023 12:19:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_intercompany_order_line (
ic_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for intercompany order'),
ic_order_pos_nr BIGNUMERIC NOT NULL OPTIONS(description='The particular position number of an item in an order'),
ic_order_dt DATE OPTIONS(description='The date when order was made'),
ic_order_create_tmsp TIMESTAMP
OPTIONS(description='The date when order was created in source system ( is used in reporting)'),
ic_order_nr STRING(20)
OPTIONS(description='The order number assigned to the intercompany sale order in the source system'),
prod_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country independent'),
prod_variant_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
dist_country_cd STRING(5)
OPTIONS(description='The unique code for a country according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
delivery_addr_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the delivery address'),
wh_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
cust_order_type_cd STRING(5) OPTIONS(description='The unique code for the customer order type'),
cust_delivery_tgt_dt DATE
OPTIONS(description='The first date which has been communicated to the customer for the expected delivery'),
cust_order_perform_dt DATE
OPTIONS(description='The date when the delivery to the customer actually started. this timestamp is relevant from a financial perspective: until then you are not allowed to charge the customer. in case of several performance timestamps for a single article within a single order, the last date is picked'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of product variant items which were ordered'),
ivp_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Internal intercompany price (net value, local currency) invoiced to the customer (in this case, intercompany partner) for the ordered product variant items'),
cogs_price_net_local_val BIGNUMERIC(38,5) OPTIONS(description='Cost of goods sold (short: cogs)'),
is_order_cancel_fg BOOL
OPTIONS(description='Flag telling whether the order position has been cancelled. customers can cancel orders only completely or not at all. lidl digital\'s call center has the possibility to cancel single positions though. therefore the position\'s flag within an order has the same value mostly, but can be different values in rare casesy'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (ic_order_sid, ic_order_pos_nr) NOT ENFORCED
)
OPTIONS(description='The order lines of the intercompany orders placed by Kaufland  where the delivery of the goods executed by Lidl');