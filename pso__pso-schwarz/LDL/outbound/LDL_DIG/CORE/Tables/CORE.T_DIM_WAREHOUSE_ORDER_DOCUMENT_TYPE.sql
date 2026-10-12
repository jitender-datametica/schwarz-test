/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_ORDER_DOCUMENT_TYPE
   GENERATED FROM POWERDESIGNER ON Dienstag, 14. Juni 2022 09:48:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_warehouse_order_document_type (
wh_order_doc_type_cd STRING(5) NOT NULL OPTIONS(description='The code for warehouse order type'),
wh_order_type_doc_descr STRING(250) NOT NULL OPTIONS(description='The description for warehouse order type'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_order_doc_type_cd) NOT ENFORCED
) OPTIONS(description='The minor dimension that holds the warehouse order type ');