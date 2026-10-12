CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_pack_size_type_2 (
pack_size_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the package_2 size type  (Normal , too long, XXL , Heavy etc)'),
pack_size_type_descr STRING(250) OPTIONS(description='A textual description for the package_2 size type'),
pack_size_handle_group_cd STRING(5)
OPTIONS(description='A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it -\' 1 person\'  ,\'2 persons\' etc'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (pack_size_type_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the package_2 size type (Normal , too long, XXL , Heavy etc)');