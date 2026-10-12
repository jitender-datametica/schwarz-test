/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_AVAILABLE_QUANTITY
   GENERATED FROM POWERDESIGNER ON Donnerstag, 22. September 2022 14:51:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_processing_available_quantity (
lgpla STRING(36) NOT NULL OPTIONS(description='Storage Bin'),
huident STRING(40) NOT NULL OPTIONS(description='Identifier'),
gu_id_stock STRING(100) NOT NULL OPTIONS(description='Src Field'),
rs_rc STRING(20) NOT NULL OPTIONS(description='Src Field'),
sap_client_id STRING(20) NOT NULL OPTIONS(description='Src Field'),
sap_sys_name STRING(20) NOT NULL OPTIONS(description='Src Field'),
wh_cd STRING(5) OPTIONS(description='lgnum '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lgpla, huident, gu_id_stock, rs_rc, sap_client_id, sap_sys_name) NOT ENFORCED
) OPTIONS(description='ETL  table to support t_fact_warehouse_order_line');