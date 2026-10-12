/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COUPON_1
   GENERATED FROM POWERDESIGNER ON Montag, 26. Februar 2024 15:47:51
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COUPON_1 (
   COUPON_ID                           VARCHAR(40)     NOT NULL COMMENT 'A identifier of the coupon. This identifier is entirely unique',
   COUPON_CD                           VARCHAR(50)     COMMENT 'A business key that uniquely identifies a coupon. Same coupon Code can be used in different campaigns',
   COUPON_PROMO_CD                     VARCHAR(50)     COMMENT 'A business key that uniquely identifies the promotion campaign to which this coupon belongs.',
   COUPON_PROMO_NAME                   VARCHAR(100)    COMMENT 'The name of the promotion campaign to which this coupon belongs.',
   COUPON_VALID_FROM_TMSP              TIMESTAMP_LTZ(9) COMMENT 'The first point in time when this coupon can be used (date when the promotion begins)',
   COUPON_VALID_TO_TMSP                TIMESTAMP_LTZ(9) COMMENT 'The last point in time when this coupon can be used (date when the promotion ends)',
   COUPON_TYPE_CD                      VARCHAR(20)     COMMENT 'Code identifying the coupon type (ex ''GENERIC'', ''PROMOTION'')',
   COUPON_DISCOUNT_TYPE_CD             VARCHAR(20)     COMMENT 'Code identifying the discount type (e.g. Monetary, Percentage, etc.)',
   COUPON_MAX_REDEMPTION_CNT           NUMBER          COMMENT 'Maximum number times this coupon  can be used by one cusotmer',
   PROD_FOOD_CLASS_CD                  VARCHAR(5)      COMMENT 'The code for the indicating if product is a food or non food',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1',
   DISCOUNT_SHIP_FG                    BOOLEAN         COMMENT 'Flag that indicates if coupon offers discount of shipping cost',
   COUPON_DISCOUNT_PCT                 NUMBER(38, 5)   COMMENT 'Discount percentage provided by the coupon.',
   COUPON_DISCOUNT_GROSS_LOCAL_VAL     NUMBER(38, 5)   COMMENT 'Gross discount amount provided by the coupon in local currency.',
   SRC_SYS_NAME                        VARCHAR(100)    COMMENT 'The name of the source system delivering the data',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_COUPON PRIMARY KEY (COUPON_ID) NOT ENFORCED 
)  COMMENT = 'The table describes promotion coupons that can be used to get discounted price for an item_1 or reduced/free shipping cost for an order. The table countains both individual (personal) coupons as well as generic coupons (coupons that are part of promotion campaign relevant to all customers)';
