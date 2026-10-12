/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_COUPON
   GENERATED FROM POWERDESIGNER ON Donnerstag, 21. April 2022 10:06:36
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_COUPON (
   COUPON_ID                           NUMBER          NOT NULL COMMENT 'A business key that uniquely identifies a coupon',
   ACTION_TYPE                         VARCHAR(100)    NOT NULL COMMENT 'Normalized values of field actions.type, Contains types of discount ("FREE_SHIPPING", "FIXED_DISCOUNT")',
   COUPON_TYPE                         VARCHAR(100)    COMMENT 'Text value describing coupon type',
   COUPON_CAMPAIGN_NAME                VARCHAR(100)    COMMENT 'Nane- of the coupon promotion campaign',
   COUPON_CAMPAIGN_ID                  VARCHAR(50)     COMMENT 'A business key that uniquely identifies the promotion campaign to which this coupon belongs.',
   REASON_ID                           NUMBER          COMMENT 'Identifier describing the reason for gifting the coupon',
   RULE                                VARIANT         COMMENT 'A JSON describing the conditions that must be satisfied so the coupon can be used.',
   ACTIONS                             VARIANT         COMMENT 'A JSON describing what benefits the coupon provide',
   COUPON_CD                           VARCHAR(50)     COMMENT 'A business key that uniquely identifies a coupon',
   COUPON_START_DATE                   DATE            COMMENT 'The first date when this coupon can be used (date when the promotion begins)',
   COUPON_END_DATE                     DATE            COMMENT 'The last date when this coupon can be used (date when the promotion ends)',
   COUPON_ISFOOD_FG                    VARCHAR(20)     COMMENT 'Describes if the coupon can be used for food or non-food products',
   ACTIVE                              BOOLEAN         COMMENT 'Flag that indicates if the coupon for this campaign is active',
   DELETED                             BOOLEAN         COMMENT 'Flag that indicates if the coupon for this campaign is deleted',
   COUPON_SOURCE                       VARCHAR(20)     COMMENT 'Source system providing the data',
   EXPIRED                             BOOLEAN         COMMENT 'Flag indicatiing if the coupon is no longer valid and cannot be used in this campaign',
   DISCOUNT_SHIP_FG                    BOOLEAN         COMMENT 'Flag that indicates if coupon offers discount of shipping cost',
   DISCOUNT_BUYX_PAYY_FG               BOOLEAN         COMMENT 'Flag that indicates if coupon allows you to buy X number of items at the price of Y items (ex. buy 3 for the price of 2)',
   DISCOUNT_FIXED_FG                   BOOLEAN         COMMENT 'Flag that indicates if coupon offers discount of product cost - a fixed amount',
   DISCOUNT_PERCENTAGE_FG              BOOLEAN         COMMENT 'Flag that indicates if coupon offers discount of product cost as percentage of the price',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_COUPON PRIMARY KEY (COUPON_ID, ACTION_TYPE) NOT ENFORCED
 )  COMMENT= 'The table contains raw source data for promotion coupons';
