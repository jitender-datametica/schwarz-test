CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_material_position_type_1 (
material_pos_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for the process type a product can be assigned to (e.g NORM, BANS).'),
material_pos_type_descr STRING(250) NOT NULL
OPTIONS(description='The description for the process type a product can be assigned to'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (material_pos_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the process type a product can be assigned to. This will also the base for determining other fields such as delivery_src_type');