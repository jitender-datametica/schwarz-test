/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_ORDER_PROCESS_STATUS_2
   GENERATED FROM POWERDESIGNER ON Montag, 13. Februar 2023 09:55:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_order_process_status_2 (
cust_order_process_status_cd STRING(5) NOT NULL
OPTIONS(description='Code that describes the overall processing status_2 of Customer Order (not started, partially completed, fully completed).             Status_2 in this field is based on the status_2 of all Delivery Orders, Warehouse Movement Orders related to this Customer Order'),
cust_order_process_status_descr STRING(250) NOT NULL
OPTIONS(description='Code that describes the overall processing status_2 of Customer Order (not started, partially completed, fully completed).             Status_2 in this field is based on the status_2 of all Delivery Orders, Warehouse Movement Orders related to this Customer Order            A Fully Completed status_2 means that all related orders for this Customer Order (meaning all Delivery Orders, Warehouse Movement Orders...) have their Overall Status_2 set to completed'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_order_process_status_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the statuses of processing a customer order');