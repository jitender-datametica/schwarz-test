/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_INTERCOMPANY_ORDER_LINE
   GENERATED FROM POWERDESIGNER ON Montag, 31. Juli 2023 12:19:17
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_INTERCOMPANY_ORDER_LINE (
   IC_ORDER_SID                        NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for intercompany order',
   IC_ORDER_POS_NR                     NUMBER          NOT NULL COMMENT 'The particular position number of an item in an order',
   IC_ORDER_DT                         DATE            COMMENT 'The date when order was made',
   IC_ORDER_CREATE_TMSP                TIMESTAMP_TZ    COMMENT 'The date when order was created in source system ( is used in reporting)',
   IC_ORDER_NR                         VARCHAR(20)     COMMENT 'The order number assigned to the intercompany sale order in the source system',
   PROD_SID                            NUMBER          COMMENT 'The unique identifier (surrogate key) for the product',
   PROD_NR                             VARCHAR(20)     COMMENT 'The number for internal onlineshop product, which is country independent',
   PROD_VARIANT_SID                    NUMBER          COMMENT 'The unique identifier (surrogate key) for the product variant',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   DIST_CHANNEL_CD                     VARCHAR(5)      COMMENT 'The code for the distribution channel ( a channel  through which the goods are sold )',
   DIST_COUNTRY_CD                     VARCHAR(5)      COMMENT 'The unique code for a country according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   CUST_SID                            NUMBER          COMMENT 'The unique identifier (surrogate key) for the customer',
   DELIVERY_ADDR_SID                   NUMBER          COMMENT 'The unique identifier (surrogate key) for the delivery address',
   WH_SID                              NUMBER          COMMENT 'The unique identifier (surrogate key) for the warehouse',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the warehouses which receives the deliveries',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   CUST_ORDER_TYPE_CD                  VARCHAR(5)      COMMENT 'The unique code for the customer order type',
   CUST_DELIVERY_TGT_DT                DATE            COMMENT 'The first date which has been communicated to the customer for the expected delivery',
   CUST_ORDER_PERFORM_DT               DATE            COMMENT 'The date when the delivery to the customer actually started. this timestamp is relevant from a financial perspective: until then you are not allowed to charge the customer. in case of several performance timestamps for a single article within a single order, the last date is picked',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of product variant items which were ordered',
   IVP_PRICE_NET_LOCAL_VAL             NUMBER(38, 5)   COMMENT 'Internal intercompany price (net value, local currency) invoiced to the customer (in this case, intercompany partner) for the ordered product variant items',
   COGS_PRICE_NET_LOCAL_VAL            NUMBER(38, 5)   COMMENT 'Cost of goods sold (short: cogs)',
   IS_ORDER_CANCEL_FG                  BOOLEAN         COMMENT 'Flag telling whether the order position has been cancelled. customers can cancel orders only completely or not at all. lidl digital''s call center has the possibility to cancel single positions though. therefore the position''s flag within an order has the same value mostly, but can be different values in rare casesy',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_INTERCOMPANY_ORDER_LINE PRIMARY KEY (IC_ORDER_SID, IC_ORDER_POS_NR) NOT ENFORCED
 )  COMMENT= 'The order lines of the intercompany orders placed by Kaufland  where the delivery of the goods executed by Lidl';
