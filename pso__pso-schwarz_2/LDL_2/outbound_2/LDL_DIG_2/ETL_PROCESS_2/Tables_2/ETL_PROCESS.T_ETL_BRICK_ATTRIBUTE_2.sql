CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_brick_attribute_2 (
attribute_internal_cd STRING(20) NOT NULL,
attribute_external_cd STRING(20),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (attribute_internal_cd) NOT ENFORCED
) OPTIONS(description='This ETL table to support brickcode .');