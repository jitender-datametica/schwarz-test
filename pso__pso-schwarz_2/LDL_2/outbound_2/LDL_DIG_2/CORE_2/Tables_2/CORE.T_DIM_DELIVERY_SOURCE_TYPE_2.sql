CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_delivery_source_type_2 (
delivery_src_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for source location_2 of product from where it is delivered i.e. from supplier_2 or warehouse directly'),
delivery_src_type_descr STRING(250) NOT NULL
OPTIONS(description='The description for source location_2 of product from where it is delivered i.e. from supplier_2 or warehouse directly'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (delivery_src_type_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines from where product is delivered (Warehouse or Supplier_2 direcly)');