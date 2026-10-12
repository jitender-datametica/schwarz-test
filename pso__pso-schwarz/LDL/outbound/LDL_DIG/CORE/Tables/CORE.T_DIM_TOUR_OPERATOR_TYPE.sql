CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_tour_operator_type (
tour_operator_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the the area of Tour Operator LT (Travel , Insurance)'),
tour_operator_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the area of Tour Operator LT (Travel , Insurance)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (tour_operator_type_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension that defines the area of Tour Operator LT workes at (Travel , Insurance)');