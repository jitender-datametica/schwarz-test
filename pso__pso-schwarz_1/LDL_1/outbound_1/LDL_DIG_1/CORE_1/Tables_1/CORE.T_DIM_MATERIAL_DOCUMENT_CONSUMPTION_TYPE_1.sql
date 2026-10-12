CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_material_document_consumption_type_1 (
material_doc_consum_type_cd STRING(20) NOT NULL
OPTIONS(description='A code to identify if the goods movement is a consumtion, no consumtion, asset, sales_1 order etc.'),
material_doc_comsum_type_descr STRING(250) NOT NULL
OPTIONS(description='A description to identify if the goods movement is a consumtion, no consumtion, asset, sales_1 order etc.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (material_doc_consum_type_cd) NOT ENFORCED
)
OPTIONS(description='The Consumption Posting is containing single letter codes to identify if the goods movement is a consumtion, no consumtion, asset, sales_1 order etc.');