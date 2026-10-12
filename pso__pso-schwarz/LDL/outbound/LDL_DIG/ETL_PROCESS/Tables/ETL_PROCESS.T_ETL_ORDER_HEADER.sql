CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_order_header (
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country.'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
dist_zone_cd STRING(25)
OPTIONS(description='The unique code for the Lidl webshop zones, where an order can be placed by a customer. The zones are defined per official administrative divisions per country.'),
cust_order_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier  for customer order ( can be return or intercompany order)'),
cust_sid BIGNUMERIC OPTIONS(description='Customer who made the order'),
sales_document_type_cd STRING(8)
OPTIONS(description='The code for the the delivery document ( C (Order), H (Return), I (Order w/o charge), V (Purchase Order) )'),
sales_channel_type_cd STRING(5)
OPTIONS(description='The code for the device which was being used to order from the online webshop. Possible values are desktop browser, iOS or Android.'),
cust_order_nr STRING(20) NOT NULL OPTIONS(description='The original order number of the source system'),
cust_order_type_cd STRING(5)
OPTIONS(description='The differenciation whether the order will be fulfilled by Lidl (=intercompany) or a supplier directly (= extracompnay).'),
cust_order_dt DATE OPTIONS(description='The date when order was made'),
prcd_elements_condition_nr STRING(20)
OPTIONS(description='ETL support field - reference to t_etl_prcd_elements_position'),
sales_segment_type_cd STRING(20) OPTIONS(description='The unique identifier (surrogate key) for the sales channel '),
order_cancel_reason_cd STRING(5)
OPTIONS(description='The code for reason why the customer has cancelled or got been cancelled an order line/product'),
cust_paym_method_cd STRING(5) OPTIONS(description='The code for the payment methods'),
delivery_addr_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the addresses'),
delivery_cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
is_order_migrated_fg BOOL OPTIONS(description='An indicator showing whether the order is migrated or not'),
is_blocked_delivery_fg BOOL
OPTIONS(description='Flag which tells whether a delivery is being blocked currently. e.g. if customer orders with payment type\"Vorauskasse\" then the delivery will only start as soon as the money arrives'),
delivery_blocked_reason_cd STRING(5)
OPTIONS(description='The code with the reason why the delivery is blocked for the specific customer order.'),
curr_cd STRING(5) OPTIONS(description='Currency code in which order has been payed'),
is_lidl_gift_card_fg BOOL OPTIONS(description='True if lidl gift card was used in the sales order'),
lidl_gift_card_local_val BIGNUMERIC(38,5) OPTIONS(description='Amount of lidl gift card used in a sales order'),
cust_order_ref_nr STRING(100)
OPTIONS(description='Customer reference no, incase of migrated sales orders: original sales order nr in legacy system'),
sales_document_reason_cd STRING(5) OPTIONS(description='The reason code for the sales document'),
lead_src_log_sys_cd STRING(100) OPTIONS(description='Technical field - source code'),
lead_src_name STRING(100) OPTIONS(description='Technical field - source name '),
overall_processing_status_cd STRING(5)
OPTIONS(description='Code for the processing status of the entire sales document'),
overall_processing_status_nr BIGNUMERIC
OPTIONS(description='Generated Number for the code for the processing status of the entire sales document'),
cust_order_tmsp TIMESTAMP
OPTIONS(description='Date and time (in UTC) when the customer finished check-out in the online shop, thus issuing the sale order.'),
dist_channel_type_cd STRING(5)
OPTIONS(description='A  type of distribution channel ( Wshop for LD Webshop , IC for Intercompany)'),
dist_country_cd STRING(5)
OPTIONS(description='The unique code for a country according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_order_sid) NOT ENFORCED
)
OPTIONS(description='ETL - The order placed from a customer within the onlineshop to receive the wanted items. Such orders can be also cancelled, returned or free resends to customers. Table contain also return orders and Intercompany orders ( orders placed on Kaufland online shop and delivered by Lidl)');