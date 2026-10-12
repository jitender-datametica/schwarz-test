/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_TRANSPORTATION_UNIT_DELIVERY_2
   GENERATED FROM POWERDESIGNER ON Montag, 17. Juni 2024 10:06:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_warehouse_transportation_unit_delivery_2 (
wh_transportation_unit_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key for the warehouse transportation unit_2 delivering the products associated with the given document order line.'),
wh_transportation_unit_activity_nr STRING(20) NOT NULL
OPTIONS(description='The unique ID for the activity of the transportation unit_2 at the warehouse. The activity relates to the process of loading and unloading, whenever a transportation unit_2 is docked at the warehouse.'),
seq_nr BIGNUMERIC NOT NULL
OPTIONS(description='The unique sequence number related to a particular delivery transported on the given transportation unit. This field serves as counter only and has no business meaning on its own.'),
wh_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
wh_transportation_unit_nr STRING(50)
OPTIONS(description='The unique ID coming from the source for the warehouse transportation unit_2 delivering the products associated with the given document order line.'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
wh_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for a warehouse order'),
wh_order_pos_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique surrogate key within the DWH for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse inbound movement. (generated from itemid + sap_client_id + sap_sys_name from the source)'),
src_wh_order_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the document generated for the particular warehouse movement. (docid in the source system)'),
src_wh_order_pos_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the position within the document generated to record the warehouse movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse movement (itemid in the source system).'),
wh_order_cat_cd STRING(10)
OPTIONS(description='The code for the category of the warehouse inbound or outbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (wh_transportation_unit_sid, wh_transportation_unit_activity_nr, seq_nr) NOT ENFORCED
)
OPTIONS(description='A Fact table that contains the details regarding the activities of the warehouse transportation units. Activities in this table represent deliveries/transportation-unit_2-movements "in" or "out" of the warehouse. The field wh_order_cat_cd shows the direction (inbound/outbound) of the deliveries..             ');