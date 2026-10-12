CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_sales_document_type_1 (
sale_doc_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for the the delivery document ( C (Order), H (Return), I (Order w/o charge), V (Purchase Order) )'),
sale_doc_type_descr STRING(250) NOT NULL OPTIONS(description='The textual description for the original document type'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (sale_doc_type_cd) NOT ENFORCED
)
OPTIONS(description='Type of the document that trigger the delivery document ( C (Order), H (Return), I (Order w/o charge), V (Purchase Order) )');