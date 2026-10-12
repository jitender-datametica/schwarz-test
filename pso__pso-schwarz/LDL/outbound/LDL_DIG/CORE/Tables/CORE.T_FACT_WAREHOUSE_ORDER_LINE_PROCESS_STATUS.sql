/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_ORDER_LINE_PROCESS_STATUS
   GENERATED FROM POWERDESIGNER ON Dienstag 2023-05-15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_warehouse_order_line_process_status (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
wh_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for a warehouse order'),
wh_order_pos_nr BIGNUMERIC NOT NULL OPTIONS(description='The particular position number of a position in an order'),
wave_id STRING(20) NOT NULL
OPTIONS(description='Number of wave (aggregation of positions which have the same picking process in the warehouse)'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
wh_order_nr STRING(20) OPTIONS(description='Delivery order number '),
wh_order_line_process_status_cd BIGNUMERIC
OPTIONS(description='The processing status of a certaing Warehouse Order Line in a Wave'),
storage_unit_nr STRING(50)
OPTIONS(description='Identification number of the storage unit used for this step of  processing. The type of storage unit can be different depending on the status (step) of the processing (for example bin/cart/trolley/pallet)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, wh_order_sid, wh_order_pos_nr, wave_id) NOT ENFORCED
)
OPTIONS(description='A fact table with the most recent processing status of an Warehouse Order Line in a Wave. We have only the status column in this separate table because statuses change frequently and we want to be able to update them quickly.');