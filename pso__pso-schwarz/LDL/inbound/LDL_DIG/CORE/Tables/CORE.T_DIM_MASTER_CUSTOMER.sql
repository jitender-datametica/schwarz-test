/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_MASTER_CUSTOMER
   GENERATED FROM POWERDESIGNER ON Donnerstag, 30. November 2023 11:59:42
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_MASTER_CUSTOMER (
   MASTER_CUST_SID                     NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the master customer',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CUST_SALUTATION                     VARCHAR(100)    COMMENT 'The salutation of the customer',
   CUST_BIRTH_DT                       DATE            COMMENT 'The birth date of the customer',
   IS_CUST_DELETED_PCU_FG              BOOLEAN         COMMENT 'The indicator to identify if a customer is deleted (e.g. on customer demand or after certain period of inactivity)',
   IS_CUST_BLOCKED_PCU_FG              BOOLEAN         COMMENT 'The indicator to identify if a customer is blocked (e.g. due to multiple unsuccessful logins)',
   IS_CUST_ADV_BLOCKED_FG              BOOLEAN         COMMENT 'The indicator to identify if a customer opted for advertisement mailings or not',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_DIM_MASTER_CUSTOMER PRIMARY KEY (MASTER_CUST_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'A dimension that holds master customer data. Master customer record consolidates data of several records from customer dimension, combining them based on definied criteria. Lidl Travel data is not consolidated with Lidl online shop data.';
