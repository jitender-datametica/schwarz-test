CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_material_document_receipt_type_2 (
material_doc_receipt_type_cd STRING(20) NOT NULL
OPTIONS(description='A code to identify if the warehouse movement is a normal receipt, stock transport order or Tied empties.'),
material_doc_receipt_type_descr STRING(250) NOT NULL
OPTIONS(description='A description to identify if the warehouse movement is a normal receipt, stock transport order or Tied empties.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (material_doc_receipt_type_cd) NOT ENFORCED
)
OPTIONS(description='The Receipt Indicator is containing single letter codes to identify if the warehouse movement is a normal receipt, stock transport order or Tied empties.');