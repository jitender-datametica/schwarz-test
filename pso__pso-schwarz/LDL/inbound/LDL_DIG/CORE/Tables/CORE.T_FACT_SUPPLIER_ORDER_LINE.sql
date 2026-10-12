/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SUPPLIER_ORDER_LINE
   GENERATED FROM POWERDESIGNER ON Freitag, 27. Oktober 2023 11:59:23
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_SUPPLIER_ORDER_LINE (
   SUPPLIER_ORDER_NR                   VARCHAR(20)     NOT NULL COMMENT 'Supplier Order Number present in the Purchase Order',
   SUPPLIER_ORDER_POS_NR               NUMBER          NOT NULL COMMENT 'Product position number on purchase order',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   PROD_VARIANT_SID                    NUMBER          COMMENT 'The unique identifier (surrogate key) for the product variant',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   SUPPLIER_ORDER_DT                   DATE            COMMENT 'The order date of the purchase document. It can be different from the creation date in SAP.',
   SUPPLIER_ORDER_CONFIRM_DT           DATE            COMMENT 'On this date the supplier confirmed that it will provide this product quantity',
   TGT_PROD_DELIVERY_DT                DATE            COMMENT 'The agreement is made for the item to be delivered at this date',
   SUPPLIER_SID                        NUMBER          COMMENT 'The unique identifier (surrogate key) for supplier account number present in the purchaseorder',
   SUPPLIER_NR                         VARCHAR(20)     COMMENT 'Account number of supplier/vendor from the sorce system',
   CUST_ORDER_SID                      NUMBER          COMMENT 'The unique identifier (surrogate key) for customer order',
   CUST_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   CUST_ORDER_POS_NR                   NUMBER          COMMENT 'The particular position number of an item in an order',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of a certain product ordered in a purchasing document',
   DELIVERED_PROD_QTY                  NUMBER(38, 5)   COMMENT 'Quantity of the product that is confirmed will be delivered. May  be more or less then ordered product quantity',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   PROD_PRICE_NET_LOCAL_VAL            NUMBER(38, 5)   COMMENT 'Net Price in document currency as was per agreement according to which purchase happend.',
   PROD_PRICE_VAT_PCT                  NUMBER(38, 5)   COMMENT 'Input tax percentage on purchased items.',
   DROPSHIPMENT_ORDER_FG               BOOLEAN         COMMENT 'An indicator on the the type of delivery orders.i.e. if a dropshipment order.',
   IS_DELIVERY_COMPLETED_FG            BOOLEAN         COMMENT 'Flag indicating if delivery from supplier to Lidl was completed',
   WH_SID                              NUMBER          COMMENT 'The unique identifier (surrogate key) for the warehouse',
   STORAGE_LOC_CD                      VARCHAR(10)     COMMENT 'The code which identifies the storage location (10001, 1002, etc)',
   SUPPLIER_ORDER_TYPE_CD              VARCHAR(5)      COMMENT 'The unique code for the purchase order document  ',
   TAX_COUNTRY_CD                      VARCHAR(5)      COMMENT 'The unique code for a country according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   TAX_TYPE_CD                         VARCHAR(5)      COMMENT 'The code identifying the tax type',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouses which receives the deliveries',
   DELETION_IN_PURCH_DOC_FG            BOOLEAN         COMMENT 'Flag indicating if position was deleted in purchasing document',
   SUPPLIER_ORDER_CANCEL_DT            DATE            COMMENT 'The date when the purchase order gets cancelled.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_FACT_SUPPLIER_ORDER_LINE PRIMARY KEY (SUPPLIER_ORDER_NR, SUPPLIER_ORDER_POS_NR, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'The order placed by Lidl purchase department ( DE ) from a supplier to buy products';
