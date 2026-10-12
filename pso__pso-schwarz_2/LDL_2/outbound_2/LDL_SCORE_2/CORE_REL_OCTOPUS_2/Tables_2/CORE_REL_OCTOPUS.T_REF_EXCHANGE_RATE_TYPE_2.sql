CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_ref_exchange_rate_type_2 (
exchange_rate_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ...'),
exchange_rate_type_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the way in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate.'),
exchange_rate_type_descr_de STRING(100)
OPTIONS(description='A textual description for the way in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate (Description in German)'),
exchange_rate_type_descr_en STRING(100)
OPTIONS(description='A textual description for the way in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate (Description in Engllish)'),
fixed_rate_fg BOOL
OPTIONS(description='An indicator showing, if the exchange rate does not change over a longer period of time, e.g. during a business year.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (exchange_rate_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the ways in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ...');