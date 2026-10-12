CREATE TABLE ETL_PROCESS.T_ETL_CUSTOMER_DELETION_1 (
   CUST_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the customer',
   DELETION_TMSP                       TIMESTAMP_TZ    COMMENT 'Timestamp when the deletion request intiated',
   DELETION_TYPE                       VARCHAR(100)    COMMENT 'Deletion sent using standard or manual process',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_CUSTOMER_DELETION PRIMARY KEY (CUST_SID) NOT ENFORCED 
)  COMMENT = 'ETL table to support the customer deletions to process GDPR requests coming for TR customers in Bosys customerprofile';
