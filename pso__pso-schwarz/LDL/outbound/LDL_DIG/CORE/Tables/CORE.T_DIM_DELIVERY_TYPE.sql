CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_delivery_type (
delivery_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for the package delivery type  (Home Delivery, Shop Delivery, Locker Delivery)'),
delivery_type_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the package delivery type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.')
)
OPTIONS(description='This minor dimension defines the package delivery type (Home Delivery, Shop Delivery, Locker Delivery)');