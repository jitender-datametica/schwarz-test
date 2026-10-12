/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_ORDER_LINE_STATUS_L9V_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 20. März 2024 11:01:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_order_line_status_l9v_2 (
wh_order_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key within the DWH for the document generated to record the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from docid + sap_client_id + sap_sys_name from the source) '),
wh_order_pos_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key within the DWH for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the particular warehouse movement - both inbound and outbound, but excluding dropshipments. (generated from itemid + sap_client_id + sap_sys_name from the source)'),
wh_order_processing_step_cd STRING(10) NOT NULL
OPTIONS(description='A short  unique code for the warehouse processing step associated with the particular order line (e.g. Wareneingang, Verpacken, etc.)'),
src_wh_order_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)'),
src_wh_order_pos_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).'),
wh_order_processing_step_status_cd STRING(10)
OPTIONS(description='A short  unique code for the status_2 of  the warehouse processing step associated with the particular order line (e.g. nicht begonnen, beendet, etc.)'),
wh_status_change_tmsp DATETIME
OPTIONS(description='The timestamp when the status_2 of the warehouse processing step associated with the particular order line was changed.'),
wh_order_cat_cd STRING(10)
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
PRIMARY KEY (wh_order_sid, wh_order_pos_sid, wh_order_processing_step_cd) NOT ENFORCED
)
OPTIONS(description='ETL  table to support loading the data coming from L9V related to the different warehouse processing steps and their status_2 changes for each order line within a document generated for a certain warehouse inbound or outbound movement (excl. dropshipments) in t_fact_warehouse_order_line_status.');