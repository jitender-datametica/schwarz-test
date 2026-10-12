/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_CUSTOMER_FINANCIAL_ORDER_2
   GENERATED FROM POWERDESIGNER ON Montag, 18. November 2024 14:26:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CUSTOMER_FINANCIAL_ORDER_2 (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop',
   CUST_ORDER_INSTALL_NR               VARCHAR(20)     NOT NULL COMMENT 'Per customer order there is one payment order, original number can be reused',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   DEBT_COLLECTION_STATUS_CD           VARCHAR(5)      COMMENT 'The code for the status_2 of the debt collection process. e.g. 01 = Receivable Released For Submission, 02 = Receivable Submitted, 12 = Receivable Cleared etc. ',
   DEBT_COLLECTION_START_DT            DATE            COMMENT 'Start date of debt collection',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',   
   CONSTRAINT PK_T_FACT_CUSTOMER_FINANCIAL_ORDER PRIMARY KEY (WSHOP_CD, CUST_ORDER_INSTALL_NR, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'For every customer order there is an internal financial order created by lidl. ( a header table to support the ETL process)';
