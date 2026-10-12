CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_brand_2 (
brand_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for brand_2'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
brand_nr STRING(20) OPTIONS(description='Account_2 number of brand_2 from the source system'),
brand_name STRING(100) OPTIONS(description='Full company name of the brand_2'),
brand_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product is classified as a Lidl own brand_2 or not'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (brand_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='Brand_2 ');