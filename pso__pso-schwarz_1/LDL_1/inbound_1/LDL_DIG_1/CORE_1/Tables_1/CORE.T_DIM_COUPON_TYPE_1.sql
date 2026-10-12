/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COUPON_TYPE_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 26. April 2022 16:33:58
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COUPON_TYPE_1 (
   COUPON_TYPE_CD                      VARCHAR(20)     NOT NULL COMMENT 'Code identifying the coupon type (ex ''GENERIC'', ''PROMOTION'')',
   COUPON_TYPE_DESCR                   VARCHAR(250)    COMMENT 'The textual descriottion for the coupon type',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_COUPON_TYPE PRIMARY KEY (COUPON_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'The minor dimension that defines the promotion coupon types ( individual, generic, promotion)';
