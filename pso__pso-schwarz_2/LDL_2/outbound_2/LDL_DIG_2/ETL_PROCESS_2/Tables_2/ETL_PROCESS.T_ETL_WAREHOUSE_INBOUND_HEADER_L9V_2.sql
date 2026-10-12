/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_INBOUND_HEADER_L9V_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 2. Juli 2024 13:29:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_inbound_header_l9v_2 (
wh_order_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key within the DWH for the document generated to record the particular warehouse inbound movement. (generated from docid + sap_client_id + sap_sys_name from the source) '),
src_wh_order_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the document generated for the particular warehouse inbound movement. (docid in the source system)'),
wh_order_nr STRING(20)
OPTIONS(description='The number of the document generated for the particular warehouse inbound movement.'),
wh_order_cat_cd STRING(6)
OPTIONS(description='The code for the category of the warehouse inbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)'),
wh_delivery_create_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the delivery was created in the EWM SAP system (NOT when it arrived into the warehouse).'),
advanced_ship_notification_nr STRING(70)
OPTIONS(description='The unique ID for the advanced shipping notification which can come from the SAP ERP system or from another system external to LIDL Digital. In case the notification comes from SAP ERP, the advanced shipping notification number = delivery_order_nr. '),
wh_sid STRING(20)
OPTIONS(description='The unique ID (surogate key) of the warehouse associated with the particular inbound movement.'),
wh_cd STRING(5)
OPTIONS(description='A short  unique code for warehouse associated with the particular inbound movement.'),
wh_order_doc_type_cd STRING(5)
OPTIONS(description='The code for the outbound delivery order document  type  which allows to group outbound delivery orders based on the count of positions and quantities in the order '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (wh_order_sid) NOT ENFORCED
) OPTIONS(description='ETL  table to support loading inbound warehouse movement data at header level  from L9V.');