/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_FINANCIAL_ACCOUNT_TRANSACTION_2
   GENERATED FROM POWERDESIGNER ON Thursday, November 28, 2024 4:08:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_financial_account_transaction_2 (
fin_acct_transaction_cd STRING(20) NOT NULL
OPTIONS(description='Unique code identifying the main transactions in the SAP Financial Accounting module.  It is used to identify the primary type of transaction, such as a payment, invoice, or credit memo.'),
fin_acct_transaction_descr STRING(250)
OPTIONS(description='A textual description for the financial account_2 transaction (e.g. Pre-payment, Reversal, Interest, etc.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (fin_acct_transaction_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the main transactions in contract accounts receivable and payable. The source is SAP TFKHVOT.');