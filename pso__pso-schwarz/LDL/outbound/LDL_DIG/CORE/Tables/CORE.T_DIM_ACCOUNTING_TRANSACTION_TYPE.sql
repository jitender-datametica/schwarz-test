/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_ACCOUNTING_TRANSACTION_TYPE
   GENERATED FROM POWERDESIGNER ON Dienstag, 10. Mai 2022 10:29:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_accounting_transaction_type (
acct_trans_type_cd STRING(20) NOT NULL OPTIONS(description='Unique identifier of the accounting transaction type'),
acct_trans_type_name_en STRING(100)
OPTIONS(description='Name (description) of the accounting transation type in English'),
acct_trans_type_name_de STRING(100)
OPTIONS(description='Name (description) of the accounting transation type in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (acct_trans_type_cd) NOT ENFORCED
)
OPTIONS(description='A minor dimension for accountring transaction type  (a. k.a Business transaction types) - they describe the origin or the type of posting (booking) made on a Cost Element  (ex. Asset Retirement, Outgoing Payment, Incoming Invoice .. )');