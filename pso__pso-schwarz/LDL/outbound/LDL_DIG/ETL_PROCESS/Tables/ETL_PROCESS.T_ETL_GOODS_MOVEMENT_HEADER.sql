/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_GOODS_MOVEMENT_HEADER
   GENERATED FROM POWERDESIGNER ON Freitag, 24. Mai 2024 10:55:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_goods_movement_header (
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
delivery_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for delivery order '),
delivery_order_nr STRING(20) NOT NULL OPTIONS(description='Delivery order number '),
goods_mov_cat_cd STRING(10)
OPTIONS(description='The code which identifies the reason why a product is moved out of the warehouse. E.g. delivery to a customer, return to a supplier, movement to another warehouse, ...'),
goods_mov_actual_tmsp TIMESTAMP OPTIONS(description='The code for the category of goods movement'),
delivery_type_cd STRING(5) OPTIONS(description='The code for the delivery type'),
delivery_route_cd STRING(50) OPTIONS(description='The code for the delivery route'),
sender_wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which sends the deliveries.'),
delivery_tgt_dt DATE
OPTIONS(description='The date which has been sent to the customer when the package is meant to arrive the latest after he ordered something in the online shop successfully.'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
wh_leave_actual_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the truck actually left the warehouse platform (\"Rampe\") from which the package is sent to the customer'),
wh_leave_tgt_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the truck is meant to leave for the specific tracking id. The time is known as CPT. The time depends on the warehouse, the carrier, the workday and the shipment type'),
distribution_status_cd STRING(5)
OPTIONS(description='Code for the processing status of the deliery in terms of decentralized Warehouse Management system processing'),
distribution_status_nr BIGNUMERIC
OPTIONS(description='Generated Number for the code for he processing status of the deliery in terms of decentralized Warehouse Management system processing'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (delivery_order_sid) NOT ENFORCED
)
OPTIONS(description='This transactional fact tracks packets that are going out of the warehouse. Includes Intercompany orders');