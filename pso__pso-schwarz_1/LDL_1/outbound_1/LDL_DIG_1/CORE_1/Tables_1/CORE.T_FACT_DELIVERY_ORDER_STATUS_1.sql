/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_DELIVERY_ORDER_STATUS_1
   GENERATED FROM POWERDESIGNER ON Montag, 13. Februar 2023 09:54:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_delivery_order_status_1 (
delivery_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for delivery order '),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
delivery_order_nr STRING(20) OPTIONS(description='Delivery order number '),
delivery_order_status_cd STRING(5)
OPTIONS(description='Status_1 of the Delivery Order. It is aggregate of the statuses of All Delivery Order Position.             Set to C (completed) means "For All SalesOrderPositions we have created associated DeliveryOrderPositions with the respective quantities that need to be delivered" It does not meat "item_1 has left the warehouse and is delivered and accepted by customer"            '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (delivery_order_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The table keeps history of changes in different statuses at Delivery Order level. These statuses are put in separate table (as opposed to T_FACT_GOODS_MOVEMENT_1)  because we want to have full history of status_1 changes and also for performance reason - we want to be able to frequently add/update statuses');