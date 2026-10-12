/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_INBOUND_POSITION_L9X_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 22. Februar 2024 15:40:09
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_WAREHOUSE_INBOUND_POSITION_L9X_1 (
   WH_ORDER_SID                        NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key within the DWH for the document generated to record the particular warehouse inbound movement. (generated from docid + sap_client_id + sap_sys_name from the source) ',
   WH_ORDER_POS_SID                    NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key within the DWH for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse inbound movement. (generated from itemid + sap_client_id + sap_sys_name from the source)',
   SRC_WH_ORDER_ID                     VARCHAR(64)     COMMENT 'The unique ID coming from the source for the document generated for the particular warehouse inbound movement. (docid in the source system)',
   SRC_WH_ORDER_POS_ID                 VARCHAR(64)     COMMENT 'The unique ID coming from the source for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse inbound movement (itemid in the source system).',
   WH_ORDER_NR                         VARCHAR(20)     COMMENT 'The number of the document generated for the particular warehouse inbound movement.',
   WH_ORDER_POS_NR                     NUMBER(38,0)    COMMENT 'The number of  the position within the document generated to record the warehouse inbound movement.',
   WH_GATE_NR                          VARCHAR(8)      COMMENT 'The number of the physical gate where the truck/product is being received. This information enables analyzing where products are received to optimize walking paths to the shelves, balance out the incoming deliveries at the gates, etc.',
   WH_ORDER_POS_CAT_CD                 VARCHAR(8)      COMMENT 'The code coming from SAP for the specific category of the product which is part of the delivery triggering the inbound warehouse movement (e.g., CGO = Transit Item_1; RET = Return Item_1; DLV = Standard Delivery Item_1, etc.)',
   WH_ORDER_POS_TYPE_CD                VARCHAR(8)      COMMENT 'The code coming from SAP for the specific type of the product which is part of the delivery triggering the inbound warehouse movement. This provides additional information clarifying wh_doc_pos_cat_cd (e.g., IDTR - belongs to the category DLV - Standard Item_1, Replenishment Delivery)',
   WH_STORAGE_PROCESS_TYPE_CD          VARCHAR(8)      COMMENT 'The code which identifies the specific storage process type within the warehouse (e.g. 3010 = Replenishment; 3040 = Repack, etc.)',
   SUPPLIER_ORDER_NR                   VARCHAR(20)     COMMENT 'The document number of the purchase order from the ERP system. One purchase order can trigger more than one inbound deliveries. For each of these deliveries, one unique document number (wh_doc_nr) will be generated but all of these document number are going to be associated with the same wh_supplier_order_nr. Some of the inbound movements are related to orders from suppliers. In that case, this is the FK to the supplier_1 order.',
   SUPPLIER_ORDER_POS_NR               VARCHAR(20)     COMMENT 'The position within the document referencing the purchase order from the ERP system.',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'The number of products at the given document position which are being delivered (as specified in the generated document that records the warehouse inbound movement, not as counted at time of arrival).',
   UOM_SID                             NUMBER          COMMENT 'A surrogate key for the unit_1 of measure of prod_qty',
   UOM_CD                              VARCHAR(8)      COMMENT 'A code for the unit_1 of measure of prod_qty.',
   PROD_CONDITION_CD                   VARCHAR(5)      COMMENT 'The condition code of the product. (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping)',
   PROD_EAN_NR                         VARCHAR(20)     COMMENT 'The EAN_1 of the product which is being delivered into the warehouse.',
   WH_SID                              VARCHAR(20)     COMMENT 'The unique ID (surogate key) of the warehouse associated with the particular inbound movement.',
   WH_CD                               VARCHAR(5)      COMMENT 'A short  unique code for warehouse associated with the particular inbound movement.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',   
   CONSTRAINT PK_T_ETL_WAREHOUSE_INBOUND_POSITION_L9X PRIMARY KEY (WH_ORDER_SID, WH_ORDER_POS_SID) NOT ENFORCED 
)  COMMENT = 'ETL  table to support loading inbound warehouse movement data at position level from L9X.';
