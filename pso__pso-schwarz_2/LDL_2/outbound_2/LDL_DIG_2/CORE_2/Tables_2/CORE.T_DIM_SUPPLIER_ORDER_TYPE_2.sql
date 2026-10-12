CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_supplier_order_type_2 (
supplier_order_type_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the purchase order document  '),
supplier_order_type_descr STRING(250) NOT NULL
OPTIONS(description='The textual description for  the purchase order document   in group language'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (supplier_order_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the document type of the purchase order document  (Standard Order, Replenishment Order, Promotion Order)');