/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_ACCOUNTING_TRANSACTION_TYPE
   GENERATED FROM POWERDESIGNER ON Dienstag, 10. Mai 2022 10:29:24
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ACCOUNTING_TRANSACTION_TYPE (
   ACCT_TRANS_TYPE_CD                  VARCHAR(20)     NOT NULL COMMENT 'Unique identifier of the accounting transaction type',
   ACCT_TRANS_TYPE_NAME_EN             VARCHAR(100)    COMMENT 'Name (description) of the accounting transation type in English',
   ACCT_TRANS_TYPE_NAME_DE             VARCHAR(100)    COMMENT 'Name (description) of the accounting transation type in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_ACCOUNTING_TRANSACTION_TYPE PRIMARY KEY (ACCT_TRANS_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'A minor dimension for accountring transaction type  (a. k.a Business transaction types) - they describe the origin or the type of posting (booking) made on a Cost Element  (ex. Asset Retirement, Outgoing Payment, Incoming Invoice .. )';
