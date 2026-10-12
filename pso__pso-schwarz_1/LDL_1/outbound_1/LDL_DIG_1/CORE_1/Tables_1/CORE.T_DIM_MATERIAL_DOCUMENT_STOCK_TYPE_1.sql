CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_material_document_stock_type_1 (
material_doc_stock_type_cd STRING(20) NOT NULL
OPTIONS(description='A code for type of stock used in material documents (3, F, S, etc..)'),
material_doc_stock_type_descr STRING(250) NOT NULL
OPTIONS(description='A description for type of stock used in material documents (Blocked, Quality inspection, etc)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (material_doc_stock_type_cd) NOT ENFORCED
)
OPTIONS(description='The minor dimension with information of type of stock in quality inspection, unrestricted or blocked for material movements');