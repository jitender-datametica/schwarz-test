/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_MATERIAL_DOCUMENT_LINE_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 27. Februar 2024 10:38:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_MATERIAL_DOCUMENT_LINE_1 (
   MATERIAL_DOC_NR                     VARCHAR(10)     NOT NULL COMMENT 'Document number of warehouse movements',
   MATERIAL_DOC_YEAR                   NUMBER          NOT NULL COMMENT 'Year of a material warehouse movement document',
   MATERIAL_DOC_POS_NR                 VARCHAR(20)     NOT NULL COMMENT 'The item_1 number of the document material',
   WH_SID                              NUMBER          COMMENT 'Code of warehouse for the physical location_1 for material movements',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouses which receives the deliveries',
   PACK_MATERIAL_NR                    VARCHAR(20)     COMMENT 'The packaging material number (e..g 420000026,  420000028)',
   PROD_VARIANT_SID                    NUMBER          COMMENT 'Product Number of a material movement document item_1',
   STORAGE_LOC_CD                      VARCHAR(10)     COMMENT 'Storage Location_1 of inbound/outbound movement',
   BOOKING_DT                          DATE            COMMENT 'Movement document date: date of goods issue or goods receipt registration in ERP System',
   BATCH_NR                            VARCHAR(20)     COMMENT 'The batch number per each product and movement ( TEST01, TEST08 ). Column is obsolete and should be removed as it is already replaced by prod_condition_cd',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   PROD_GROSS_LOC_VAL                  NUMBER(38, 5)   COMMENT 'Value in local currency (gross) of material movement on position level of warehouse movement document which will be added or removed to/from the current value of the corresponding material stock. Value of total quantity of corresponding position. This column has an incorrect name and will be replaced by prod_net_local_val.',
   PROD_NET_LOCAL_VAL                  NUMBER(38, 5)   COMMENT 'Value in local currency (net) of material movement on position level of warehouse movement document which will be added or removed to/from the current value of the corresponding material stock. Value of total quantity of corresponding position.	',
   PROD_QTY                            NUMBER(38, 0)   COMMENT 'Quantity of products in unit_1 measure (e.g. 1 unit_1 of product)',
   UOM_SID                             NUMBER          COMMENT 'A surrogate key for the unit_1 of measure - Unit_1 of quantity in "inventory unit_1".',
   ENTRY_PROD_QTY                      NUMBER(38, 0)   COMMENT 'Quantity of products in unit_1 of entry',
   ENTRY_UOM_SID                       NUMBER          COMMENT 'A surrogate key for the unit_1 of entry measure - Unit_1 of quantity in "input" unit. The unit_1 depends on application that create the document (purchase order, sales_1 shipment, inventory etc. and of user behaviour).',
   MATERIAL_DOC_STOCK_TYPE_CD          VARCHAR(20)     COMMENT 'A code for type of stock used in material documents (3, F, S, etc..)',
   MATERIAL_DOC_MOV_TYPE_CD            VARCHAR(20)     COMMENT 'Code of product movement in warehouse on position level of warehouse-movement-document (per product_variant, storage and booking date) 
            For Example: 101 - Goods receipt (WE Wareneingang), 601 - Goods issue/goods delivery (WL WarenausLieferung), 451 - Goods issue returns (WA Retouren)',
   MATERIAL_DOC_SPECIAL_STOCK_TYPE_CD  VARCHAR(20)     COMMENT 'A code for type of special stock such as Customer Stock, Project Stock, Stock in Transit ',
   MATERIAL_DOC_MOV_REASON_CD          VARCHAR(20)     COMMENT 'A code for the  reason for the goods movement - The Movement Indicator is containing single letter codes to identify the reason for the goods movement such as goods movement w/o reference, goods movement for purchase order, goods movement for production order etc.',
   MATERIAL_DOC_MOV_CAUSE_CD           NUMBER          COMMENT 'A code to identify what causes the movement of the material in/out or within a warehouse.',
   MATERIAL_DOC_CONSUM_TYPE_CD         VARCHAR(20)     COMMENT 'A code to identify if the goods movement is a consumtion, no consumtion, asset, sales_1 order etc.',
   MATERIAL_DOC_RECEIPT_TYPE_CD        VARCHAR(20)     COMMENT 'A code to identify if the warehouse movement is a normal receipt, stock transport order or Tied empties.',
   MATERIAL_DOC_DEBIT_CREDIT_CD        VARCHAR(20)     COMMENT 'A code for material goods debit credit indicator',
   MATERIAL_DOC_MOV_PROCESS_TYPE_NAME  VARCHAR(50)     COMMENT 'Indicator of the process for which the material document has been created. Examples can be Verwertung (Recycling) or Verschrottung (Scrapping).',
   MATERIAL_DOC_MOV_PROCESS_SUBTYPE_NAME VARCHAR(200)    COMMENT 'Detailed explanation of the process for which the material document has been created. Example can be Recycling of old stock through Powerseller / Recycling through Greencycling',
   PROD_REVENUE_NET_LOCAL_VAL          NUMBER(38, 5)   COMMENT 'Value amount of the revenue generated by the material document line for the considered process. For example, when we recycle a product we reclaim part of its original value as revenue',
   PROD_LOSS_NET_LOCAL_VAL             NUMBER(38, 5)   COMMENT 'Value amount of the loss generated by the material document line for the considered process.',
   DELIVERY_ORDER_SID                  NUMBER          COMMENT 'The unique identifier (surrogate key) for delivery order ',
   DELIVERY_ORDER_POS_NR               NUMBER          COMMENT 'The position order number from the system that processes deliveries',
   CUST_SID                            NUMBER          COMMENT 'The unique identifier (surrogate key) for the customer',
   SUPPLIER_ORDER_NR                   VARCHAR(20)     COMMENT 'Supplier_1 Order Number present in the Purchase Order',
   SUPPLIER_ORDER_POS_NR               NUMBER          COMMENT 'Product position number on purchase order',
   CUST_ORDER_SID                      NUMBER          COMMENT 'The unique identifier (surrogate key) for customer order',
   CUST_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   CUST_ORDER_POS_NR                   NUMBER          COMMENT 'The particular position number of an item_1 in an order',
   DELIVERY_SRC_TYPE_CD                VARCHAR(5)      COMMENT 'The code for source location_1 of product from where it is delivered i.e. from supplier_1 or warehouse directly',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   UOM_CD                              VARCHAR(5)      COMMENT 'A code for the unit_1 of measure - Unit_1 of quantity in "inventory unit_1".',
   ENTRY_UOM_CD                        VARCHAR(5)      COMMENT 'A code for the unit_1 of entry measure - Unit_1 of quantity in "input" unit. The unit_1 depends on application that create the document (purchase order, sales_1 shipment, inventory etc. and of user behaviour).',
   REF_DOC_NR                          VARCHAR(20)     COMMENT 'A reference number for linking a material document with a billing document',
   REF_DOC_POS_NR                      VARCHAR(20)     COMMENT 'A reference number for linking a material document position with a billing document position',
   PROD_CONDITION_CD                   VARCHAR(20)     COMMENT 'The condition code of the product. (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_FACT_MATERIAL_DOCUMENT_LINE PRIMARY KEY (MATERIAL_DOC_NR, MATERIAL_DOC_YEAR, MATERIAL_DOC_POS_NR) NOT ENFORCED 
)  COMMENT = 'The table contains details for "material documents" - documents which describe movements of goods in, out or inside a warehouse
             These movements are created based on a Goods Movement Order/Delivery Order (in SAP terms Delivery Document)
             Several material documen can be created for one Delivery Order, and depending if this is an order associated with supplier_1 (purchase for example) or a customer(sale for example)  the corresponding references are filled ( supplier_order_nr, cust_order_sid). For other types of Delivery Orders both fields could be empty.
             
             Main src - SAP ERP - table MSEG (in SAP terms "material document items")
             ';
