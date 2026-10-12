/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_PROCESSING_ORDER_1
   GENERATED FROM POWERDESIGNER ON Montag, 15. Juli 2024 14:42:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_processing_order_1 (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
wh_order_sid BIGNUMERIC NOT NULL OPTIONS(description='Surrogate Key for warehouse order'),
wh_order_pos_nr BIGNUMERIC NOT NULL OPTIONS(description='Position Number'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
doc_cat STRING(6) NOT NULL OPTIONS(description='Document Category'),
doc_no STRING(20) OPTIONS(description='Document Number'),
item_no BIGNUMERIC OPTIONS(description='Position number'),
wh_order_pos_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique surrogate key within the DWH for the position within the document generated to record the warehouse outbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse outbound movement. (generated from itemid + sap_client_id + sap_sys_name from the source)'),
src_wh_order_pos_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the position within the document generated to record the warehouse outbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse outbound movement (itemid in the source system).'),
wh_order_nr STRING(20) OPTIONS(description='Number uniquely identifying a document of outbound delivery orders'),
doc_id STRING(64) NOT NULL OPTIONS(description='Document ID'),
item_id STRING(64) NOT NULL OPTIONS(description='Item_1 Id '),
wave_cd STRING(5) OPTIONS(description='Wave Flag'),
wh_cd STRING(5) OPTIONS(description='Warehouse code'),
hu_id STRING(64) OPTIONS(description='Identifier'),
guid_parent_cd STRING(64)
OPTIONS(description='Needed for Ludwigsfelde Lager Cockpit in where condition in update sql t_fact_warehouse_processing_1 to map referenced guid'),
guid_lagp_cd STRING(64)
OPTIONS(description='Needed for Ludwigsfelde Lager Cockpit in update sql t_fact_warehouse_processing_1 to calculate filed flag_quittiert_clearing'),
scwm_procty STRING(8) OPTIONS(description='Sap Client Identifier'),
sap_client_id STRING(20) OPTIONS(description='Sap Client Identifier'),
sap_sys_name STRING(20) OPTIONS(description='Sap System Name'),
who_status_cd STRING(20) OPTIONS(description='Status_1 Code'),
to_status_cd STRING(20) OPTIONS(description='Status_1 Code'),
prod_variant_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product ordered'),
wh_goods_issue_status_cd STRING(5) OPTIONS(description='The code for warehouse goods issue status_1 -0,1,9'),
out_invoice_dt DATE OPTIONS(description='Date of outgoing invoice document for a customer delivery order'),
outbound_tmsp TIMESTAMP OPTIONS(description='Date and time when the outbound process has happened'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (dwh_valid_from_tmsp, wh_order_pos_nr, wh_order_sid, wh_sid) NOT ENFORCED
) OPTIONS(description='ETL  table to support t_fact_warehouse_order_line_1');