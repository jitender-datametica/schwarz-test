/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_PICKED_STOCK_QUANTITY
   GENERATED FROM POWERDESIGNER ON Dienstag, 16. Mai 2023 16:10:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_processing_picked_stock_quantity (
sap_client_id STRING(20) NOT NULL OPTIONS(description='Src Field'),
sap_sys_name STRING(20) NOT NULL OPTIONS(description='Src Field'),
gu_id_parent STRING(100) NOT NULL OPTIONS(description='Src Field'),
gu_id_stock STRING(100) NOT NULL OPTIONS(description='Src Field'),
virtual_stock_indicator STRING(5) NOT NULL OPTIONS(description='Src Field'),
stock_unit_of_measure STRING(5) NOT NULL OPTIONS(description='Src Field'),
actual_pick_qty BIGNUMERIC(38,5)
OPTIONS(description='The actual quantity after the picking is fully done - when there is no warehouse task or wave assigned - then it means there is a real handling unit physically picked.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (gu_id_parent, gu_id_stock, sap_client_id, sap_sys_name, virtual_stock_indicator, stock_unit_of_measure)
NOT ENFORCED
)
OPTIONS(description='ETL  table to support t_fact_warehouse_processing. Source SAP EWM (table LIME/NQUAN)              Contains data for open Warehouse Task - Reserve specific quantity for the Warehouse Task             Entry will be set to zero when Warehouse Task is confirmed or cancelled');