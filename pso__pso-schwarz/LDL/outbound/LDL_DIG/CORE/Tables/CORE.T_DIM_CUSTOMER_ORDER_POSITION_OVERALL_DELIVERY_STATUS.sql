/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_ORDER_POSITION_OVERALL_DELIVERY_STATUS
   GENERATED FROM POWERDESIGNER ON Montag, 13. Februar 2023 09:55:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_order_position_overall_delivery_status (
cust_order_pos_overall_delivery_status_cd STRING(5) NOT NULL
OPTIONS(description='Code that describes the overall delivery order. status of customer order position (not started, partially completed, fully completed).             A " Fully Completed" delivery order status in this case means that for everrything that HAS TO BE DELIVERED a completed Delivery Order exists.            If we have rejection this means that there is nothing to be delivered and we sill count this as "Completed").            '),
cust_order_pos_overall_delivery_status_descr STRING(250) NOT NULL
OPTIONS(description='Code that describes the overall delivery order. status of customer order position (not started, partially completed, fully completed).             A " Fully Completed" delivery order status in this case means that for everrything that HAS TO BE DELIVERED a completed Delivery Order exists.            If we have rejection this means that there is nothing to be delivered and we sill count this as "Completed").            '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_order_pos_overall_delivery_status_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the delivery statuses of each customer order position. If a customer rejects delivery the status will still be completed, because we have nothing left to deliver');