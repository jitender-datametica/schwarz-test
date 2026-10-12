/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_INBOUND_POSITION_L9V
   GENERATED FROM POWERDESIGNER ON Donnerstag, 22. Februar 2024 15:39:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_inbound_position_l9v (
wh_order_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key within the DWH for the document generated to record the particular warehouse inbound movement. (generated from docid + sap_client_id + sap_sys_name from the source) '),
wh_order_pos_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key within the DWH for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse inbound movement. (generated from itemid + sap_client_id + sap_sys_name from the source)'),
src_wh_order_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the document generated for the particular warehouse inbound movement. (docid in the source system)'),
src_wh_order_pos_id STRING(64)
OPTIONS(description='The unique ID coming from the source for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse inbound movement (itemid in the source system).'),
wh_order_nr STRING(20)
OPTIONS(description='The number of the document generated for the particular warehouse inbound movement.'),
wh_order_pos_nr BIGNUMERIC(38,0)
OPTIONS(description='The number of  the position within the document generated to record the warehouse inbound movement.'),
wh_gate_nr STRING(8)
OPTIONS(description='The number of the physical gate where the truck/product is being received. This information enables analyzing where products are received to optimize walking paths to the shelves, balance out the incoming deliveries at the gates, etc.'),
wh_order_pos_cat_cd STRING(8)
OPTIONS(description='The code coming from SAP for the specific category of the product which is part of the delivery triggering the inbound warehouse movement (e.g., CGO = Transit Item; RET = Return Item; DLV = Standard Delivery Item, etc.)'),
wh_order_pos_type_cd STRING(8)
OPTIONS(description='The code coming from SAP for the specific type of the product which is part of the delivery triggering the inbound warehouse movement. This provides additional information clarifying wh_doc_pos_cat_cd (e.g., IDTR - belongs to the category DLV - Standard Item, Replenishment Delivery)'),
wh_storage_process_type_cd STRING(8)
OPTIONS(description='The code which identifies the specific storage process type within the warehouse (e.g. 3010 = Replenishment; 3040 = Repack, etc.)'),
supplier_order_nr STRING(20)
OPTIONS(description='The document number of the purchase order from the ERP system. One purchase order can trigger more than one inbound deliveries. For each of these deliveries, one unique document number (wh_doc_nr) will be generated but all of these document number are going to be associated with the same wh_supplier_order_nr. Some of the inbound movements are related to orders from suppliers. In that case, this is the FK to the supplier order.'),
supplier_order_pos_nr STRING(20)
OPTIONS(description='The position within the document referencing the purchase order from the ERP system.'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
prod_qty BIGNUMERIC(38,5)
OPTIONS(description='The number of products at the given document position which are being delivered (as specified in the generated document that records the warehouse inbound movement, not as counted at time of arrival).'),
uom_sid BIGNUMERIC OPTIONS(description='A surrogate key for the unit of measure of prod_qty'),
uom_cd STRING(8) OPTIONS(description='A code for the unit of measure of prod_qty.'),
prod_condition_cd STRING(5)
OPTIONS(description='The condition code of the product. (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping)'),
prod_ean_nr STRING(20) OPTIONS(description='The EAN of the product which is being delivered into the warehouse.'),
wh_sid STRING(20)
OPTIONS(description='The unique ID (surogate key) of the warehouse associated with the particular inbound movement.'),
wh_cd STRING(5)
OPTIONS(description='A short  unique code for warehouse associated with the particular inbound movement.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (wh_order_sid, wh_order_pos_sid) NOT ENFORCED
) OPTIONS(description='ETL  table to support loading inbound warehouse movement data at position level from L9V.');