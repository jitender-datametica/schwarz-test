CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_material_document_movement_type (
material_doc_mov_type_cd STRING(20) NOT NULL OPTIONS(description='A code for product movement  (101, 601 , etc)'),
material_doc_mov_type_descr STRING(250) NOT NULL
OPTIONS(description='A description for product movement  ( Goods receipt , Goods issue/goods delivery, etc )'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (material_doc_mov_type_cd) NOT ENFORCED
)
OPTIONS(description='The minor dimension describing types of product movement in warehouse on position level of warehouse-movement-document.');