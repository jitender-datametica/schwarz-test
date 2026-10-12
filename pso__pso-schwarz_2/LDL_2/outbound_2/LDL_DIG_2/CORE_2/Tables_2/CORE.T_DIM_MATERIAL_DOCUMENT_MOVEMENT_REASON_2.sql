CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_material_document_movement_reason_2 (
material_doc_mov_reason_cd STRING(20) NOT NULL OPTIONS(description='A code for the  reason for the goods movement '),
material_doc_mov_reason_descr STRING(250) NOT NULL
OPTIONS(description='A description for the  reason for the goods movement '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
PRIMARY KEY (material_doc_mov_reason_cd) NOT ENFORCED
)
OPTIONS(description='The Movement Indicator is containing single letter codes to identify the  reason for the goods movement such as goods movement w/o reference, goods movement for purchase order, goods movement for production order etc.');