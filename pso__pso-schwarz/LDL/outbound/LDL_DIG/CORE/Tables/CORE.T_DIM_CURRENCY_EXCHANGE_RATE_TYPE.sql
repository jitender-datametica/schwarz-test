CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_currency_exchange_rate_type (
curr_exchange_rate_type_cd STRING(5) NOT NULL
OPTIONS(description='The code identifying the way in which one currency can be converted into another.'),
curr_exchange_rate_type_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the way in which one currency can be converted into another expressed in group language, i.e. in German.'),
is_general_used_fg BOOL OPTIONS(description='If exchange rate is used in daily reportimg'),
is_lidl_headoffice_used_fg BOOL OPTIONS(description='If exchange rate is used in the report to lidl headquater'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (curr_exchange_rate_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the the ways in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ...');