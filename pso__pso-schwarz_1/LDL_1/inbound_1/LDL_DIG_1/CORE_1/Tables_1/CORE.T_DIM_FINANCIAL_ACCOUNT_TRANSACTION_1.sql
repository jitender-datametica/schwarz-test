/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_FINANCIAL_ACCOUNT_TRANSACTION_1
   GENERATED FROM POWERDESIGNER ON Thursday, November 28, 2024 4:08:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_FINANCIAL_ACCOUNT_TRANSACTION_1 (
   FIN_ACCT_TRANSACTION_CD             VARCHAR(20)     NOT NULL COMMENT 'Unique code identifying the main transactions in the SAP Financial Accounting module.  It is used to identify the primary type of transaction, such as a payment, invoice, or credit memo.',
   FIN_ACCT_TRANSACTION_DESCR          VARCHAR(250)    COMMENT 'A textual description for the financial account_1 transaction (e.g. Pre-payment, Reversal, Interest, etc.)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_FINANCIAL_ACCOUNT_TRANSACTION PRIMARY KEY (FIN_ACCT_TRANSACTION_CD) NOT ENFORCED 
)  COMMENT = 'This minor dimension defines the main transactions in contract accounts receivable and payable. The source is SAP TFKHVOT.';
