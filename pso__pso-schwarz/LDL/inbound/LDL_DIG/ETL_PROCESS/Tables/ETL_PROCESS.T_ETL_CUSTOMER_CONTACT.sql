CREATE TABLE ETL_PROCESS.T_ETL_CUSTOMER_CONTACT (
   ADDR_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the addresses',
   CUST_SID                            NUMBER          COMMENT 'The unique identifier (surrogate key) for the customer',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CONTACT_CUST_NR                     VARCHAR(20)     COMMENT 'A customer number from original system',
   CUST_ADDR_NR                        VARCHAR(100)    COMMENT 'Original address numbers in source system',
   PHONE_NR                            VARCHAR(100)    COMMENT 'The phone number of the customer',
   EMAIL                               VARCHAR(100)    COMMENT 'The email address of the customer',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_ETL_CUSTOMER_CONTACT PRIMARY KEY (ADDR_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'Etl table to support development of t_customer'
DATA_RETENTION_TIME_IN_DAYS = 7
;