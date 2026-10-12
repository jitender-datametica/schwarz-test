CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_material_document_special_stock_type_1 (
material_doc_special_stock_type_cd STRING(20) NOT NULL
OPTIONS(description='A code for type of special stock such as Customer Stock, Project Stock, Stock in Transit '),
material_doc_special_stock_type_descr STRING(250) NOT NULL
OPTIONS(description='A description for type of special stock such as Customer Stock, Project Stock, Stock in Transit '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (material_doc_special_stock_type_cd) NOT ENFORCED
)
OPTIONS(description='The Special Stock Indicator is containing single letter codes to identify the allocation of the articles to the different stock types, such as Customer Stock, Project Stock, Stock in Transit ');