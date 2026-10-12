/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_GOODS_MOVEMENT_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 2. Oktober 2024 13:45:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_goods_movement_1 (
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
delivery_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for delivery order '),
delivery_order_nr STRING(20) NOT NULL OPTIONS(description='Delivery order number '),
delivery_order_pos_nr BIGNUMERIC NOT NULL
OPTIONS(description='The particular position number of a position in an order'),
goods_mov_cat_cd STRING(10)
OPTIONS(description='The code which identifies the reason why a product is moved out of the warehouse. E.g. delivery to a customer, return to a supplier_1, movement to another warehouse, ...'),
goods_mov_cat_group_cd STRING(10)
OPTIONS(description='The code which identifies the reason why a product is moved out of the warehouse. E.g. delivery to a customer, return to a supplier_1, movement to another warehouse, ...'),
goods_mov_orig_tmsp TIMESTAMP
OPTIONS(description='The original goods movement timestamp of the order. In case the order gets split because the ordered items cannot fit in one package_1, there will be a difference between goods_mov_orig_tmsp and goods_mov_actual_tmsp. Otherwise, goods_mov_orig_tmsp should be the same as goods_mov_actual_tmsp.'),
goods_mov_actual_tmsp TIMESTAMP
OPTIONS(description='The actual goods movement timestamp based on the category'),
delivery_addr_sid BIGNUMERIC
OPTIONS(description='The unique identifier (sk) for the delivery address_1 where original order was delivered'),
prod_variant_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
delivery_prod_qty BIGNUMERIC(38,5) OPTIONS(description='The number of products that are to be delivered'),
delivery_type_cd STRING(5) OPTIONS(description='The code to identify the delivery type'),
delivery_route_cd STRING(50) OPTIONS(description='The code to identify delivery route'),
recipient_country_cd STRING(5) OPTIONS(description='The recipient country_1 code'),
stock_placement_cd STRING(10)
OPTIONS(description='The code which identifies the storage type indicator for stock placement.'),
stock_removal_cd STRING(10)
OPTIONS(description='The code which identifies the storage type indicator for stock removal.'),
order_item_category_cd STRING(5) OPTIONS(description='The code to uniquely identify the order item_1 categories'),
cust_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of an item_1 in an order'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
wh_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
sender_wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which sends the deliveries.'),
storage_loc_cd STRING(10) OPTIONS(description='The code which identifies the storage location_1 (10001, 1002, etc)'),
sale_doc_type_cd STRING(5)
OPTIONS(description='The code for the the delivery document ( C (Order), H (Return), I (Order w/o charge), V (Purchase Order) )'),
delivery_tgt_dt DATE
OPTIONS(description='First date which has been communicated to the customer until when the shipment is meant to arrive'),
wh_leave_actual_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the truck actually left the warehouse platform (\"Rampe\") from which the package_1 is sent to the customer'),
wh_leave_tgt_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the truck is meant to leave for the specific tracking id. The time is known as CPT. The time depends on the warehouse, the carrier, the workday and the shipment type'),
wh_arrive_actual_dt DATE OPTIONS(description='Date on which the goods were placed in the warehouse.'),
ic_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for intercompany order'),
ic_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of an item_1 in an order'),
ic_order_nr STRING(20)
OPTIONS(description='The order number assigned to the intercompany sale order in the source system'),
supplier_order_nr STRING(20)
OPTIONS(description='This field holds the document number of the reference document. In case of dropshipments, the reference document corresponds to the supplier_1 order number (purchase order number) which took place after the sales_1 order.'),
supplier_order_pos_nr BIGNUMERIC OPTIONS(description='Product position number on purchase order'),
dropshipment_order_fg BOOL
OPTIONS(description='In case the product is being sent directly from the supplier_1 this field will be filled.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (delivery_order_sid, delivery_order_pos_nr) NOT ENFORCED
)
OPTIONS(description='This transactional fact tracks packets that are going out /in of the warehouse ( including dropshipments)');