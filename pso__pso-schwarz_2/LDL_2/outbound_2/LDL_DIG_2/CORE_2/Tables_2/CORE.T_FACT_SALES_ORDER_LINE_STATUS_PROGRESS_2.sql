/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SALES_ORDER_LINE_STATUS_PROGRESS_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 1. November 2023 10:48:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_sales_order_line_status_progress_2 (
sale_order_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for customer order'),
sale_order_pos_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='A number of an particular position ( product ) in an order'),
delivery_order_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for delivery order '),
pack_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the package.'),
wshop_cd STRING(5) OPTIONS(description='Sales_2 Organization/Webshop through which the order was placed'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
sale_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
sale_order_dt DATE OPTIONS(description='The date when order was made'),
delivery_order_nr STRING(20) OPTIONS(description='The order number from the system that processes deliveries'),
pack_order_nr STRING(20)
OPTIONS(description='The order number within warehouse system which tells which articles are part of which package_2'),
is_blocked_delivery_fg BOOL
OPTIONS(description='Flag which tells whether a delivery is being blocked currently. e.g. if customer orders with payment type\"Vorauskasse\" then the delivery will only start as soon as the money arrives'),
delivery_blocked_reason_cd STRING(5)
OPTIONS(description='The code with the reason why the delivery is blocked for the specific customer order.'),
sale_order_process_status_cd STRING(5)
OPTIONS(description='Code that describes the overall processing status_2 of Customer Order (not started, partially completed, fully completed).             Status_2 in this field is based on the status_2 of all Delivery Orders, Warehouse Movement Orders related to this Customer Order'),
sale_order_pos_delivery_status_cd STRING(5)
OPTIONS(description='Code that describes the delivery order status_2 of customer order position (not started, partially completed, fully completed).             A " Fully Completed" delivery order status_2 in this case means that for everrything that was ordered we have  a completed Delivery Order.            If we have rejection by customer this means that one or more Delivery Orders are not Completed so the status_2 here will also never be Completed.            So status_2 here can be changed back from "Fully Completed" to "Partially Completed" for example'),
sale_order_pos_overall_delivery_status_cd STRING(5)
OPTIONS(description='Code that describes the overall delivery order. status_2 of customer order position (not started, partially completed, fully completed).             A " Fully Completed" delivery order status_2 in this case means that for everrything that HAS TO BE DELIVERED a completed Delivery Order exists.            If we have rejection this means that there is nothing to be delivered and we sill count this as "Completed").            '),
wh_sid BIGNUMERIC
OPTIONS(description='The unique identifier (sk) for the warehouse from where particular product will be sent'),
prod_variant_sid BIGNUMERIC OPTIONS(description='Ordered product'),
prod_tgt_delivery_time BIGNUMERIC
OPTIONS(description='This field comes from the VLT-Tool and tells how much time is expected for the delivery for a specific product variant. The value is country_2 dependant.'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product ordered'),
delivery_src_type_cd STRING(5)
OPTIONS(description='The code for source location_2 of product from where it is delivered i.e. from supplier_2 or warehouse directly'),
delivery_type_cd STRING(5)
OPTIONS(description='The code for the package_2 delivery type  (Home Delivery, Shop Delivery, Locker Delivery)'),
delivery_tgt_dt DATE
OPTIONS(description='First date which has been communicated to the customer until when the shipment is meant to arrive'),
hauler_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for hauler'),
cust_order_type_cd STRING(5) OPTIONS(description='The unique code for the customer order type'),
wh_leave_actual_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the truck actually left the warehouse platform (\"Rampe\") from which the package_2 is sent to the customer'),
wh_leave_tgt_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the truck is meant to leave for the specific tracking id. The time is known as CPT. The time depends on the warehouse, the carrier, the workday and the shipment type'),
delivery_prod_qty BIGNUMERIC(38,5) OPTIONS(description='The number of products that are to be delivered'),
delivery_order_status_cd STRING(5)
OPTIONS(description='Status_2 of the Delivery Order. It is aggregate of the statuses of All Delivery Order Position.             Set to C (completed) means "For All SalesOrderPositions we have created associated DeliveryOrderPositions with the respective quantities that need to be delivered" It does not meat "item_2 has left the warehouse and is delivered and accepted by customer"            '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (sale_order_sid, sale_order_pos_nr, delivery_order_sid, pack_sid) NOT ENFORCED
)
OPTIONS(description='An accumulating snapshot_2 fact table which tracks the progress in the steps through which a Sales_2 Order Position goes in the warehouse before being sent. (Customer Order created, Delviery Document created, Package_2 Created)             Sales_2 Order Position  can be Intercompany Order Position or Customer Order Position              The granularity is one row per combination of Sales_2 Order Position + PackageSID becasue items from one position could be sent in more than one package.             Tables is used to simplify (and enable higher frequency of) anlalysis like  how many Orders do not have Delivery Document created or Package_2 for example. ');