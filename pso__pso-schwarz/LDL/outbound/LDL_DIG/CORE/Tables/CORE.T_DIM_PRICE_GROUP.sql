CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_price_group (
price_group_cd STRING(20) NOT NULL OPTIONS(description='Code of pricing group - internal or customer facing'),
price_group_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for thepricing group in group language (German)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (price_group_cd) NOT ENFORCED
) OPTIONS(description='Code of pricing group - internal or customer facing');