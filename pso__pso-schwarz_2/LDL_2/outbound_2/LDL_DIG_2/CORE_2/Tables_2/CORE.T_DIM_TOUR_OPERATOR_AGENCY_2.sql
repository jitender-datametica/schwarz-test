CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_tour_operator_agency_2 (
tour_operator_agency_cd STRING(100) NOT NULL OPTIONS(description='The code for identifying tour_2 operator agency code'),
tour_operator_cd STRING(50) OPTIONS(description='The unique code for identifying tour_2 operator'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (tour_operator_agency_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the tour_2 operator agency details (there can be many tour_2 operator agency code or no agency code under one tour_2 operator code)');