CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_currency_1 (
curr_cd STRING(5) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
curr_name STRING(250) NOT NULL OPTIONS(description='A textual description for the currency.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (curr_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the currency codes according to ISO-4217. (E.g. EUR, USD, GBP, ...)');