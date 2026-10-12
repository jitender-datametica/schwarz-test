/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_ORDER_HANDLING_UNIT_REL
   GENERATED FROM POWERDESIGNER ON Dienstag, 14. Mai 2024 16:46:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_warehouse_order_handling_unit_rel (
handling_unit_sid BIGNUMERIC NOT NULL
OPTIONS(description='Surrogate Key of the Handling Unit. Generated based on src_handling_unit_id, sap_sys_name, sap_client_id            A Handling unit is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin. '),
wh_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for a warehouse order'),
wh_order_cat_cd STRING(10) NOT NULL
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
OPTIONS(description='A Relational Table that relates warehouse orders with handling units. A Handling unit is a generic term  for a container or a bin that is used to transport items within a warehouse. Several Items can be stored in one container/bin.              ');