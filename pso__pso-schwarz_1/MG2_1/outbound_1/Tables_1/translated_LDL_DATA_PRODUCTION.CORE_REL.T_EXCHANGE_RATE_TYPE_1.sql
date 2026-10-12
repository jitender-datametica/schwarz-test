CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_exchange_rate_type_1 (
exchange_rate_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ...'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
exchange_rate_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ...'),
fixed_rate_fg BOOL
OPTIONS(description='An indicator showing, if the exchange rate does not change over a longer period of time, e.g. during a business year.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (exchange_rate_type_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the ways in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ...');