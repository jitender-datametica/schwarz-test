/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_MEANS_OF_TRANSPORT_L8V
   GENERATED FROM POWERDESIGNER ON Mittwoch, 19. Februar 2025 10:36:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_means_of_transport_l8v (
wh_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) for warehouse order'),
src_wh_order_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)'),
wh_order_pos_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key within the DWH for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement. (generated from itemid + sap_client_id + sap_sys_name from the source)'),
src_wh_order_pos_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).'),
scheduled_wh_order_pos_nr STRING(64) NOT NULL
OPTIONS(description='Not in use, always has same value. Could be used if the items in one position from one order are NOT sent at once, but on several batches.            In such case there will be a schedule when each batch will be sent. In such case for each batch there will be a different value in this column.'),
counter_id BIGNUMERIC NOT NULL
OPTIONS(description='Used for foreign key relationship so that entries are restricted to those that appear within the primary key of the check table.'),
wh_order_cat_cd STRING(6)
OPTIONS(description='The code for the category of the warehouse inbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)'),
transport_mode_cd STRING(20)
OPTIONS(description='This field indicates the mode of the transport means. It describes how the goods are being transported, such as by truck, ship, airplane, or train.Example: Currently not in use'),
transport_mode_id STRING(20)
OPTIONS(description='This is the unique identification number of the transport means. It can be a vehicle number, container number, or any other specific identifier that uniquely identifies the transport means.Example: E180624016L'),
transport_mode_type_cd STRING(20)
OPTIONS(description='This field describes the type of the transport means. It indicates whether it is a container, trailer, ship, airplane, truck etc.                        Example: ZTRK'),
transport_mode_category_cd STRING(20)
OPTIONS(description='This is a code that contains additional information about the transport means. It can be a standardized code that describes certain characteristics or classifications of the transport means.                        Example: 3002'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_order_sid, wh_order_pos_sid, scheduled_wh_order_pos_nr, counter_id) NOT ENFORCED
)
OPTIONS(description='ETL  table  for means of transport / delivery transportation data.                          Source: /SCDL/DB_TRANS table in  L8V source system.');