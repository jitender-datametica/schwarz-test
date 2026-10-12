/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_TRANSPORTATION_UNIT_DELIVERY_L9X_2
   GENERATED FROM POWERDESIGNER ON Montag, 10. Juni 2024 15:30:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_transportation_unit_delivery_l9x_2 (
wh_transportation_unit_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key for the warehouse transportation unit. The SID is generated based on wh_transportation_unit_nr, sap_client_id and sap_system_name. '),
wh_transportation_unit_activity_nr STRING(20) NOT NULL
OPTIONS(description='The unique ID for the activity of the transportation unit_2 at the warehouse. The activity relates to the process of loading and unloading, whenever a transportation unit_2 is docked at the warehouse. '),
seq_nr BIGNUMERIC NOT NULL
OPTIONS(description='The unique sequence number related to a particular delivery transported on the given transportation unit. This field serves as counter only and has no business meaning on its own.'),
wh_transportation_unit_nr STRING(50)
OPTIONS(description='The unique internal ID for the warehouse transportation unit_2 delivering the products associated with a given order line. This internal ID is generated for the originally provided warehouse transportation unit_2 number by the external transportation service provider (alt_wh_transportation_unit_nr).  In case the alternate warehouse transportation unit_2 number changes, the internal ID will remain the same and there will be another row for the new unique combination of alt_wh_transportation_unit_nr and wh_transportation_unit_nr'),
wh_sid STRING(20)
OPTIONS(description='The unique ID (surogate key) of the warehouse associated with the particular inbound or outbound movement.'),
wh_cd STRING(5)
OPTIONS(description='A short unique code for the warehouse associated with the particular inbound or outbound movement.'),
wh_order_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key within the DWH for the document generated to record the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from docid + sap_client_id + sap_sys_name from the source) '),
wh_order_pos_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key within the DWH for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from itemid + sap_client_id + sap_sys_name from the source)'),
src_wh_order_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)'),
src_wh_order_pos_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).'),
wh_order_cat_cd STRING(6) NOT NULL
OPTIONS(description='The code for the category of the warehouse inbound or outbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (wh_transportation_unit_sid, wh_transportation_unit_activity_nr, seq_nr) NOT ENFORCED
)
OPTIONS(description='ETL table to support loading the data coming from L9X related to warehouse transportation units.              Each transportation unit_2 carries specific deliveries.             These deliveries are associated with specific order lines within a document generated for a certain warehouse inbound or outbound movement.             The field wh_order_cat_cd shows the direction (inbound/outbound) of the deliveries.');