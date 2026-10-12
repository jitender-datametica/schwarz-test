/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_ORDER_LINE_1
   GENERATED FROM POWERDESIGNER ON Montag, 15. Juli 2024 14:41:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_warehouse_order_line_1 (
wh_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for a warehouse order'),
wh_order_pos_nr BIGNUMERIC NOT NULL
OPTIONS(description='The particular position number within a document of an outbound delivery order'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
wshop_cd STRING(5) OPTIONS(description='Sales_1 Organization/Webshop through which the order was placed'),
wh_order_nr STRING(20) OPTIONS(description='Number uniquely identifying a document of outbound delivery orders'),
wh_order_pos_id STRING(80)
OPTIONS(description='A technical field, which is being used by business to filter on a specific warehouse-order-number-position-combination within the SAP GUI.'),
wh_order_pos_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique surrogate key within the DWH for the position within the document generated to record the warehouse outbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse outbound movement. (generated from itemid + sap_client_id + sap_sys_name from the source)'),
src_wh_order_pos_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the position within the document generated to record the warehouse outbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse outbound movement (itemid in the source system).'),
wh_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
prod_variant_sid BIGNUMERIC OPTIONS(description='Ordered product of outbound delivery order'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity per product of outbound delivery order'),
out_invoice_dt DATE OPTIONS(description='Date of outgoing invoice document for a customer delivery order'),
wh_order_doc_type_cd STRING(5)
OPTIONS(description='The code for the outbound delivery order document  type  which allows to group outbound delivery orders based on the count of positions and quantities in the order '),
wh_goods_issue_status_cd STRING(5) OPTIONS(description='The code for warehouse goods issue status_1 -0,1,9'),
wh_order_create_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the warehouse order was created '),
wh_order_ship_type_name STRING(5)
OPTIONS(description='Type names for deliveries, which have the same type of destination, like e.g. packing stations'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
is_order_in_progress_fg BOOL
OPTIONS(description='This field indicates whether the warehouse order number and its associated tasks and waves are currently in progress. Based on this flag, the values are being taken into consideration within the Lager Cockpit or not'),
outbound_tmsp TIMESTAMP OPTIONS(description='Date and time when the outbound process has happened'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (wh_order_sid, wh_order_pos_nr, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This transactional fact tracks EWM ( SAP enterprise warehouse managent)  delivery documents of the warehouse.- a.k.a Warehouse Orders             Such documents are created in the EWM system as a result of Delivery Orders in ERP system (see table T_FACT_GOODS_MOVEMENT_1)             One ERP Delivery Order can be the reason for creating several warehouse orders.                          NOTE! This table contains Warehouse Orders related ONLY to OUTBOUND Delivery Orders. When the table was created it was believed these are the only goods movements in the EWM system that would be analyzed and imported in the DWH. However this is now changed and we have separate table for Inbound Warehouse Orders and at some point this table should be rename to T_FACT_OUTBOUND_WAREHOUSE_MOVEMENT maybe.                           Historization is introduced to keep track of status_1 progress,                          Main Src - SAP EWM  tables /SCDL/DB_PROCH_O and /SCDL/DB_PROCI_O');