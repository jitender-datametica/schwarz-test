/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_DELIVERY_ORDER_STATUS_2
   GENERATED FROM POWERDESIGNER ON Montag, 13. Februar 2023 09:56:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_delivery_order_status_2 (
delivery_order_status_cd STRING(5) NOT NULL
OPTIONS(description='Status_2 of the Delivery Order document. It is aggregate of the statuses of All Delivery Order Position. '),
delivery_order_status_descr STRING(250) NOT NULL
OPTIONS(description='Status_2 of the Delivery Order document. It is aggregate of the statuses of All Delivery Order Position.             Set to C (completed) means "For All SalesOrderPositions we have created associated DeliveryOrderPositions with the respective quantities that need to be delivered" It does not meat "item_2 has left the warehouse and is delivered and accepted by customer"            '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (delivery_order_status_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the statuses of a delivering order. Not to be confused with actual transporting of items from a warehouse to a customer.             A Delivery Order is a document. Such document has a status_2 Completed when all  position (lines) from this document are associated with Customer Sales_2 order, which means all required items to fulfil a customer order are present in a warehouse.');