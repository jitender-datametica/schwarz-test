/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COUPON_DISCOUNT_TYPE
   GENERATED FROM POWERDESIGNER ON Montag, 28. August 2023 14:19:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COUPON_DISCOUNT_TYPE (
   COUPON_DISCOUNT_TYPE_CD             VARCHAR(20)     NOT NULL COMMENT 'Code identifying the discount type (e.g. Monetary, Percentage, etc.)',
   COUPON_DISCOUNT_TYPE_DESCR          VARCHAR(250)    COMMENT 'The textual description for the coupon discount type',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',

   CONSTRAINT PK_T_DIM_COUPON_DISCOUNT_TYPE PRIMARY KEY (COUPON_DISCOUNT_TYPE_CD) NOT ENFORCED
)  COMMENT = 'The minor dimension that defines the promotion coupon discount types ( monetary, percentage, X for Y, etc.)';
