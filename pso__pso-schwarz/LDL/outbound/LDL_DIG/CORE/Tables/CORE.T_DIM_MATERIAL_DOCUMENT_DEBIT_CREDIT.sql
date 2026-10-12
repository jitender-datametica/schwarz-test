CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_material_document_debit_credit (
material_doc_debit_credit_cd STRING(20) NOT NULL OPTIONS(description='A code for material goods debit credit indicator'),
material_doc_debit_credit_descr STRING(250) NOT NULL
OPTIONS(description='A description for material goods debit credit indicator'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (material_doc_debit_credit_cd) NOT ENFORCED
)
OPTIONS(description='The minor dimension to store values of indicator of goods issue (\'H\') or goods receipt (\'S\') for material movements');