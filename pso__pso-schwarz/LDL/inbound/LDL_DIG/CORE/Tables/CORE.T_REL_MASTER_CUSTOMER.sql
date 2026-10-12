/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_MASTER_CUSTOMER
   GENERATED FROM POWERDESIGNER ON Montag, 20. November 2023 08:43:00
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_MASTER_CUSTOMER (
   MASTER_CUST_SID                     NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the master customer',
   CUST_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the customer',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CUST_TYPE_CD                        VARCHAR(5)      COMMENT 'The code for the customer type to differentiate whether an online shop or travel customer',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_REL_MASTER_CUSTOMER PRIMARY KEY (DWH_VALID_FROM_TMSP, CUST_SID) NOT ENFORCED
 )  COMMENT= 'A dimension that holds relationship between customer and master customer data. One customer is related to only one master record at a time, master customer record consolidates data of several records from customer dimension. Does not contain GDPR protected data';
