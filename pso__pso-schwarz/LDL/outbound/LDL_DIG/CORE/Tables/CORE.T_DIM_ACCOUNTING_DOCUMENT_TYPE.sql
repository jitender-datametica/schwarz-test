/* --------------------------------------------------------------------------------
   DDL FOR TABLE: CORE.T_DIM_ACCOUNTING_DOCUMENT_TYPE
   GENERATED FROM POWERDESIGNER ON Mittwoch, 9. Februar 2022 10:15:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_accounting_document_type (
acct_doc_type_cd STRING(5) NOT NULL OPTIONS(description='Unique identifier of the document type'),
acc_doc_type_name_en STRING(100) OPTIONS(description='Name (description) of the accounting document type in English'),
acc_doc_type_name_de STRING(100) OPTIONS(description='Name (description) of the accounting document type in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (acct_doc_type_cd) NOT ENFORCED
) OPTIONS(description='A minor dimension that contains all the types of Accounting Documents');