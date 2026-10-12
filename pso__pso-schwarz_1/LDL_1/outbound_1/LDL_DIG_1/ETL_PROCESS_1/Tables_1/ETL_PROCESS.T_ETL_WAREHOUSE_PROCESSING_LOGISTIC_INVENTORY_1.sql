/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_LOGISTIC_INVENTORY_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 22. September 2022 14:52:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_processing_logistic_inventory_1 (
wh_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (sk) for warehouse order'),
wh_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of a position in an order'),
actual_pick_qty BIGNUMERIC(38,5)
OPTIONS(description='The actual quantity after the picking is fully done - when there is no warehouse task or wave assigned - then it means there is a real handling unit_1 physically picked.'),
gu_id_parent STRING(100) NOT NULL OPTIONS(description='Src Field'),
gu_id_stock STRING(100) NOT NULL OPTIONS(description='Src Field'),
sap_client_id STRING(20) NOT NULL OPTIONS(description='Src Field'),
sap_sys_name STRING(20) NOT NULL OPTIONS(description='Src Field'),
qdocid STRING(64) OPTIONS(description='Src Field'),
qitemid STRING(64) OPTIONS(description='Src Field'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (gu_id_parent, gu_id_stock, sap_client_id, sap_sys_name) NOT ENFORCED
) OPTIONS(description='ETL  table to support t_fact_warehouse_processing_1');