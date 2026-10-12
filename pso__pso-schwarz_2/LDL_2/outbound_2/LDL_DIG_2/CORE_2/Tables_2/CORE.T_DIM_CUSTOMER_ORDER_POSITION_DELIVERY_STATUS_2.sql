/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_ORDER_POSITION_DELIVERY_STATUS_2
   GENERATED FROM POWERDESIGNER ON Montag, 13. Februar 2023 09:55:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_order_position_delivery_status_2 (
cust_order_pos_delivery_status_cd STRING(5) NOT NULL
OPTIONS(description='Code that describes the delivery order status_2 of customer order position (not started, partially completed, fully completed).             The status_2 answers the question "Can we deliver everything that was ordered?". If customer rejects something then we cannot deliver it and status_2 will never be completed.            '),
cust_order_pos_delivery_status_descr STRING(250) NOT NULL
OPTIONS(description='Code that describes the delivery order status_2 of customer order position (not started, partially completed, fully completed).             The status_2 answers the question "Can we deliver everything that was ordered?". If customer rejects something then we cannot deliver it and status_2 will never be completed.            A " Fully Completed" delivery order status_2 in this case means that for everrything that was ordered we have  a completed Delivery Order.            So status_2 here can be changed back from "Fully Completed" to "Partially Completed" for example'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_order_pos_delivery_status_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the delivery statuses of each customer order position. If a customer rejects delivery the status_2 will NOT  be completed, because we cannot deliver everything that is ordered');