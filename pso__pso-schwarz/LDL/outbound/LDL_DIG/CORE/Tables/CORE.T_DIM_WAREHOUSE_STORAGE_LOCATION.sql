CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_warehouse_storage_location (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
storage_loc_cd STRING(10) NOT NULL
OPTIONS(description='The code which identifies the storage location (10001, 1002, etc)'),
storage_loc_descr STRING(250)
OPTIONS(description='A textual description for  the storage location (Main Storage, Customer Returns, etc)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_sid, storage_loc_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the type of the storage location (1001 - Main Storage, 1002 - Customer Returns, etc)');