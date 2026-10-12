CREATE OR REPLACE TABLE szd_production_etl.t_etl_exchange_rate_chargelog_a_2 (
source_currency_cd STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - The code identifying the currency, according to ISO 4217.'),
target_currency_cd STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - The code identifying the currency, according to ISO 4217.'),
exchange_rate_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - The code identifying the way in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ...'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
exchange_rate NUMERIC(29,5) NOT NULL
OPTIONS(description='The factor by which the amount in the source currency needs to be multiplied, so that the result is in the target currency.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (source_currency_cd, target_currency_cd, exchange_rate_type_cd, dwh_valid_from_tmsp) NOT ENFORCED
);