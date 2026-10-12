/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_INBOUND_MOVEMENT
   GENERATED FROM POWERDESIGNER ON Dienstag, 2. Juli 2024 13:33:16
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_WAREHOUSE_INBOUND_MOVEMENT (
   WH_ORDER_SID                        NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key within the DWH for the document generated to record the particular warehouse inbound movement. (generated from docid + sap_client_id + sap_sys_name from the source) ',
   WH_ORDER_POS_SID                    NUMBER(38,0)    NOT NULL COMMENT 'The unique surrogate key within the DWH for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse inbound movement. (generated from itemid + sap_client_id + sap_sys_name from the source)',
   SRC_WH_ORDER_ID                     VARCHAR(64)     COMMENT 'The unique ID coming from the source for the document generated for the particular warehouse inbound movement. (docid in the source system)',
   SRC_WH_ORDER_POS_ID                 VARCHAR(64)     COMMENT 'The unique ID coming from the source for the position within the document generated to record the warehouse inbound movement. There can be multiple document positions within one document which reference the same product but represent different process steps within the warehouse inbound movement (itemid in the source system).',
   WH_ORDER_NR                         VARCHAR(20)     COMMENT 'The number of the document generated for the particular warehouse inbound movement.',
   WH_ORDER_POS_NR                     NUMBER(38,0)    COMMENT 'The number of  the position within the document generated to record the warehouse inbound movement.',
   WH_GATE_NR                          VARCHAR(8)      COMMENT 'The number of the physical gate where the truck/product is being received. This information enables analyzing where products are received to optimize walking paths to the shelves, balance out the incoming deliveries at the gates, etc.',
   WH_ORDER_CAT_CD                     VARCHAR(10)     COMMENT 'The code for the category of the warehouse inbound movement document (e.g., IDR = Inbound Delivery Notification; PDI = Inbound Delivery, etc.)',
   WH_ORDER_POS_CAT_CD                 VARCHAR(8)      COMMENT 'The code coming from SAP for the specific category of the product which is part of the delivery triggering the inbound warehouse movement (e.g., CGO = Transit Item; RET = Return Item; DLV = Standard Delivery Item, etc.)',
   WH_ORDER_POS_TYPE_CD                VARCHAR(8)      COMMENT 'The code coming from SAP for the specific type of the product which is part of the delivery triggering the inbound warehouse movement. This provides additional information clarifying wh_doc_pos_cat_cd (e.g., IDTR - belongs to the category DLV - Standard Item, Replenishment Delivery)',
   WH_STORAGE_PROCESS_TYPE_CD          VARCHAR(8)      COMMENT 'The code which identifies the specific storage process type within the warehouse (e.g. 3010 = Replenishment; 3040 = Repack, etc.)',
   SUPPLIER_ORDER_NR                   VARCHAR(20)     COMMENT 'The document number of the purchase order from the ERP system. One purchase order can trigger more than one inbound deliveries. For each of these deliveries, one unique document number (wh_doc_nr) will be generated but all of these document number are going to be associated with the same wh_supplier_order_nr. Some of the inbound movements are related to orders from suppliers. In that case, this is the FK to the supplier order.',
   SUPPLIER_ORDER_POS_NR               VARCHAR(20)     COMMENT 'The position within the document referencing the purchase order from the ERP system.',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'The number of products at the given document position which are being delivered (as specified in the generated document that records the warehouse inbound movement, not as counted at time of arrival).',
   UOM_SID                             NUMBER          COMMENT 'A surrogate key for the unit of measure of prod_qty',
   UOM_CD                              VARCHAR(8)      COMMENT 'A code for the unit of measure of  prod_qty.',
   PROD_CONDITION_CD                   VARCHAR(5)      COMMENT 'The condition code of the product. (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping)',
   PROD_EAN_NR                         VARCHAR(20)     COMMENT 'The EAN of the product which is being delivered into the warehouse.',
   WH_DELIVERY_CREATE_TMSP             TIMESTAMP_LTZ(9) COMMENT 'The timestamp when the delivery was created in the EWM SAP system (NOT when it arrived into the warehouse).',
   WH_SID                              VARCHAR(20)     COMMENT 'The unique ID (surogate key) of the warehouse associated with the particular inbound movement.',
   WH_CD                               VARCHAR(5)      COMMENT 'A short  unique code for warehouse associated with the particular inbound movement.',
   WH_ORDER_DOC_TYPE_CD                VARCHAR(5)      COMMENT 'The code for the inbound or outbound delivery order document  type  which allows to group delivery orders based on the count of positions and quantities in the order ',
   ADVANCED_SHIP_NOTIFICATION_NR       VARCHAR(70)     COMMENT 'The unique ID for the advanced shipping notification which can come from the SAP ERP system or from another system external to LIDL Digital. In case the notification comes from SAP ERP, the advanced shipping notification number = delivery_order_nr. ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_FACT_WAREHOUSE_INBOUND_MOVEMENT PRIMARY KEY (WH_ORDER_SID, WH_ORDER_POS_SID) NOT ENFORCED 
)  COMMENT = 'This fact table tracks EWM documents related to inbound warehouse movements at position level. 
             These documents originate as a result of a given process in the ERP system (e.g. the product X will be loaded into warehouse Y on XX/XX/XXXX) - this process itself is captured in T_FACT_GOODS_MOVEMENT. 
             The EWM system then keeps record of a number of documents resulting from this one (e.g. a document stating that the product has been admitted into the warehouse, another document that states that the product was allocated to a specific area in the warehouse, etc.) 
             This document can contain several positions related to one or to multiple different products. Each of these positions describes specific process steps related to how the given product(s) is handled within the warehouse. 
             Within the core model, we refer to these documents as inbound orders and to the document positions as inbound order positions.
             ';
