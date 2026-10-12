/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_DEBT_COLLECTION_STATUS_2
   GENERATED FROM POWERDESIGNER ON Montag, 18. November 2024 14:28:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_debt_collection_status_2 (
debt_collection_status_cd STRING(5) NOT NULL
OPTIONS(description='The code for the status_2 of the debt collection process. e.g. 01 = Receivable Released For Submission, 02 = Receivable Submitted, 12 = Receivable Cleared etc. '),
debt_collection_status_descr STRING(250) NOT NULL
OPTIONS(description='The description for the status_2 of the debt collection process.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (debt_collection_status_cd) NOT ENFORCED
) OPTIONS(description='A minor dimension that defines the status_2 of the debt collection process.');