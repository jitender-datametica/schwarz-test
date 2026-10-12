CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_tour_operator_1 (
tour_operator_cd STRING(50) NOT NULL OPTIONS(description='The code for the tour_1 operator'),
tour_operator_name STRING(100) NOT NULL OPTIONS(description='The name of tour_1 operator'),
tour_operator_type_cd STRING(20)
OPTIONS(description='Differentiates the area of Tour_1 Operator LT cooperates with (Travel , Insurance)'),
tour_operator_contract_type_cd STRING(20)
OPTIONS(description='Code for the type of contract for Tour_1 Operator LT ( Iframe , mittelbar,  unmittelbar)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (tour_operator_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the tour_1 operator details');