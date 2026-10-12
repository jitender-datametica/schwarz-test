/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_EMAIL_COUPON
   GENERATED FROM POWERDESIGNER ON Dienstag, 14. Juni 2022 11:34:54
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_EMAIL_COUPON (
   JOB_ID                              NUMBER          NOT NULL COMMENT 'The jobid number of the respective engagement event job ',
   COUPON_CD                           VARCHAR(50)     NOT NULL COMMENT 'The business key that uniquely identifies a coupon',
   SUBSCR_SID                          NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the subscriber',
   CLAIM_DT                            DATE            COMMENT 'The date when the coupon was claimed',
   COUPON_PROMO_NAME                   VARCHAR(100)     COMMENT 'The type of coupon code',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_EMAIL_COUPON PRIMARY KEY (JOB_ID, COUPON_CD, SUBSCR_SID) NOT ENFORCED
 )  COMMENT= 'The ETL lookup table based on the source files coupons_couponsallocation_last5days to get coupon_cd';
