/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COUPON_LEGACY_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 22. August 2023 08:46:12
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_DIM_COUPON_LEGACY_1 (
   COUPON_ID                           NUMBER          NOT NULL COMMENT 'A identifier of the coupon. This identifier is entirely unique',
   COUPON_CD                           VARCHAR(50)     COMMENT 'A business key that uniquely identifies a coupon. Same coupon Code can be used in different campaigns',
   COUPON_PROMO_CD                     VARCHAR(50)     COMMENT 'A business key that uniquely identifies the promotion campaign to which this coupon belongs.',
   COUPON_PROMO_NAME                   VARCHAR(100)    COMMENT 'The name of the promotion campaign to which this coupon belongs.',
   COUPON_VALID_FROM_TMSP              TIMESTAMP_LTZ(9) COMMENT 'The first point in time when this coupon can be used (date when the promotion begins)',
   COUPON_VALID_TO_TMSP                TIMESTAMP_LTZ(9) COMMENT 'The last point in time when this coupon can be used (date when the promotion ends)',
   COUPON_TYPE_CD                      VARCHAR(20)     COMMENT 'Code identifying the coupon type (ex ''GENERIC'', ''PROMOTION'')',
   COUPON_MAX_REDEMPTION_CNT           NUMBER          COMMENT 'Maximum number times this coupon  can be used by one cusotmer',
   PROD_FOOD_CLASS_CD                  VARCHAR(5)      COMMENT 'The code for the indicating if product is a food or non food',
   DISCOUNT_SHIP_FG                    BOOLEAN         COMMENT 'Flag that indicates if coupon offers discount of shipping cost',
   DISCOUNT_PERCENTAGE_FG              BOOLEAN         COMMENT 'Flag that indicates if coupon offers discount of product cost as percentage of the price',
   DISCOUNT_FIXED_FG                   BOOLEAN         COMMENT 'Flag that indicates if coupon offers discount of product cost - a fixed amount',
   DISCOUNT_BUYX_PAYY_FG               BOOLEAN         COMMENT 'Flag that indicates if coupon allows you to buy X number of items at the price of Y items (ex. buy 3 for the price of 2)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_COUPON_LEGACY PRIMARY KEY (COUPON_ID) NOT ENFORCED
 )  COMMENT= 'The table contains legacy coupon data coming from a decommissioned source system and describes promotion coupons that were used to get discounted price for an item_1 or reduced/free shipping cost for an order. The table countains both individual (personal) coupons as well as generic coupons (coupons that are part of promotion campaign relevant to all customers)';
