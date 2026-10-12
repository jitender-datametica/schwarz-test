/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_HANDLING_UNIT_REFERENCE_L9X
   GENERATED FROM POWERDESIGNER ON Montag, 29. April 2024 09:31:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_processing_handling_unit_reference_l9x (
handling_unit_sid BIGNUMERIC NOT NULL
OPTIONS(description='Surrogate Key of the Handling Unit. Generated based on src_handling_unit_id, sap_sys_name, sap_client_id            A Handling unit is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. '),
wh_order_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key within the DWH for the document generated to record the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from docid + sap_client_id + sap_sys_name from the source) '),
wh_order_cat_cd STRING(6) NOT NULL
OPTIONS(description='The code for the category of the warehouse inbound or outbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)'),
src_handling_unit_id STRING(64)
OPTIONS(description='The ID of the Handling Unit in the source system            A Handling unit is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. '),
src_wh_order_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (handling_unit_sid, wh_order_sid, wh_order_cat_cd) NOT ENFORCED
)
OPTIONS(description='ETL  table to support T_FACT_WAREHOUSE_PROCESSING from L9X source system.                          The reason WH_ORDER_SID is also part of the PK is because in some occasions it is not known and we have a default value, so in this case in one handling_unit we can have two different wh_order_cat_cd (for inbound and outbound).');