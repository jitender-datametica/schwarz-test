/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_TASK_ORDER_2
   GENERATED FROM POWERDESIGNER ON Samstag, 1. Oktober 2022 12:17:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_processing_task_order_2 (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) of  warehouse'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
who_id BIGNUMERIC NOT NULL OPTIONS(description='Identifier'),
who_status_cd STRING(2) OPTIONS(description='Identifier'),
who_queue_cd STRING(20) OPTIONS(description='Identifier'),
who_lgnum_cd STRING(8) NOT NULL OPTIONS(description='Identifier'),
sap_sys_name STRING(20) OPTIONS(description='Name'),
sap_client_id STRING(20) OPTIONS(description='Identifier'),
created_at_tmsp TIMESTAMP OPTIONS(description='Timestamp'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, who_id, who_lgnum_cd) NOT ENFORCED
) OPTIONS(description='ETL  table to support T_FACT_WAREHOUSE_PROCESSING_2');