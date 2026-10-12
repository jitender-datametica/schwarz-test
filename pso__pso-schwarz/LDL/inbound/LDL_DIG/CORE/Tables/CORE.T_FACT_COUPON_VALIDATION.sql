/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_COUPON_VALIDATION
   GENERATED FROM POWERDESIGNER ON Donnerstag, 24. August 2023 14:46:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_COUPON_VALIDATION (
   COUPON_VALIDATION_NR                NUMBER          NOT NULL COMMENT 'Unique identifier of the coupon redemption event',
   CUST_ORDER_SID                      NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for customer order',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'Ordered product',
   COUPON_ID                           VARCHAR(40)     COMMENT 'A identifier of the coupon. This identifier is entirely unique',
   COUPON_CD                           VARCHAR(50)     COMMENT 'A business key that uniquely identifies a coupong',
   COUPON_PROMO_CD                     VARCHAR(50)     COMMENT 'A business key that uniquely identifies the promotion campaign to which this coupon belongs.',
   PROFIT_LOSS_REASON_CD               VARCHAR(5)      COMMENT 'The code for the reason of profit/loss  ( 327, 326... etc)',
   CURR_CD                             VARCHAR(5)      COMMENT 'Currency code in which order has been payed',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of a particular product ordered',
   COUPON_VALIDATION_TMSP              TIMESTAMP_LTZ(9) COMMENT 'Point in time when coupon was used in an order',
   COUPON_SHIP_GROSS_LOCAL_VAL         NUMBER(38, 5)   COMMENT 'The discount amount of the shipping cost (allocated to this product) provided by the coupon ',
   COUPON_ITEM_GROSS_LOCAL_VAL         NUMBER(38, 5)   COMMENT 'Discount amount for single product item  provided by the coupon',
   COUPON_POS_GROSS_LOCAL_VAL          NUMBER(38, 5)   COMMENT 'Discount amount for the order positions (all items ot this product) provided by the coupon',
   CUST_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_COUPON_VALIDATION PRIMARY KEY (COUPON_VALIDATION_NR, CUST_ORDER_SID, PROD_VARIANT_SID) NOT ENFORCED
 )  COMMENT= 'Table contains events of discount coupons applied to an order ';
