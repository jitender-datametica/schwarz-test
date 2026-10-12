/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SALES_ORDER_STATUS
   GENERATED FROM POWERDESIGNER ON Donnerstag, 13. Juli 2023 11:50:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_sales_order_status (
sale_order_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for sales order ( customer or intercompany)'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
sale_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
sale_order_process_status_cd STRING(5)
OPTIONS(description='Code that describes the overall processing status of Sales Order (not started, partially completed, fully completed).             Status in this field is based on the status of all Delivery Orders, Warehouse Movement Orders related to this Customer Order'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (sale_order_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The table keeps history of changes in different statuses (like delivery, processing) at Sales Order level (Customer Order and Intercompany Order ) level. These statuses are put in separate table (as opposed to putting them in T_FACT_CUSTOMER_ORDER_LINE  or T_FACT_INTERCOMPANY_ORDER_LINE) because we want to have full history of status changes and also for performance reason - we want to be able to frequently add/update statuses');