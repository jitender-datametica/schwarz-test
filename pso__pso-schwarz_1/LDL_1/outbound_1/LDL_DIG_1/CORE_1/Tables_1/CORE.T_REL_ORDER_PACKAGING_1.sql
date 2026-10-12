/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_ORDER_PACKAGING_1
   GENERATED FROM POWERDESIGNER ON Montag, 12. August 2024 07:48:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_order_packaging_1 (
pack_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the package.'),
pack_pos_nr STRING(20) NOT NULL OPTIONS(description='The position number of the package_1'),
prod_variant_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
delivery_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for delivery order '),
delivery_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of a position in an order'),
delivery_order_nr STRING(20) OPTIONS(description='The order number from the system that processes deliveries'),
cust_order_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_pos_nr BIGNUMERIC(38,0) OPTIONS(description='The particular position number of an item_1 in an order'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
ic_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for intercompany order'),
ic_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of an item_1 in an order'),
ic_order_nr STRING(20)
OPTIONS(description='The order number assigned to the intercompany sale order in the source system'),
deliv_prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a specific product within a specific package_1'),
deliv_prod_price BIGNUMERIC(38,5) OPTIONS(description='Price of a specific product within a specifc package_1'),
deliv_prod_val BIGNUMERIC(38,5) OPTIONS(description='Value of a specific product within a specific package_1'),
pack_order_nr STRING(20)
OPTIONS(description='The order number within warehouse system which tells which articles are part of which package_1'),
ship_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The shipping costs for Lidl Digital for each article included in a package_1 (Only Forward process)'),
delivery_to_point_of_use_fg BOOL
OPTIONS(description='Flag indicating if the product will be delivered to the point of use.'),
delivery_pick_up_for_recycling_fg BOOL
OPTIONS(description='Flag that the old device will be picked up with the delivery of the new'),
delivery_label_for_recycling_fg BOOL
OPTIONS(description='Flag indicating that the customer will send the old device with a label. No pick-up.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (pack_sid, pack_pos_nr) NOT ENFORCED
)
OPTIONS(description='One order line contains several items ( for example 5 flower pots) can be send in one or several packages ( 2+3  flower pots) or be combined with items from other order lines in one package. Table contains both customer orders and IC orders.');