/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_DEBT_COLLECTION_STATUS
   GENERATED FROM POWERDESIGNER ON Montag, 18. November 2024 14:28:07
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_DEBT_COLLECTION_STATUS (
   DEBT_COLLECTION_STATUS_CD           VARCHAR(5)      NOT NULL COMMENT 'The code for the status of the debt collection process. e.g. 01 = Receivable Released For Submission, 02 = Receivable Submitted, 12 = Receivable Cleared etc. ',
   DEBT_COLLECTION_STATUS_DESCR        VARCHAR(250)    NOT NULL COMMENT 'The description for the status of the debt collection process.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_DIM_DEBT_COLLECTION_STATUS PRIMARY KEY (DEBT_COLLECTION_STATUS_CD) NOT ENFORCED 
)  COMMENT = 'A minor dimension that defines the status of the debt collection process.';
