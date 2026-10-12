CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_unit_of_measurement (
uom_sid BIGNUMERIC NOT NULL OPTIONS(description='A surrogate key for the unit of measure.'),
uom_cd STRING(5) NOT NULL OPTIONS(description='A code for the unit of measure.'),
uom_descr STRING(100)
OPTIONS(description='A textual description for the uom_cd written out in group language (German).'),
uom_standard_sid BIGNUMERIC OPTIONS(description='A surrogate key for the standard unit of measure.'),
uom_standard_cd STRING(5) OPTIONS(description='A code for the standard unit of measure.'),
uom_standard_multipl_meas BIGNUMERIC(38,10)
OPTIONS(description='A multiplicator that is used to convert a measure to standard unit of measure'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (uom_sid) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the unit of measure');