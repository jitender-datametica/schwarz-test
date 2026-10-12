CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_exchange_rate_type_2 (
exchange_rate_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way in which one currency can be converted into another.'),
exchange_rate_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way in which one currency can be converted into another expressed in group language, i.e. in German.'),
exchange_rate_type_descr_de STRING(250)
OPTIONS(description='A textual description for the way in which one currency can be converted into another expressed in German.'),
exchange_rate_type_descr_en STRING(250)
OPTIONS(description='A textual description for the way in which one currency can be converted into another expressed in English.'),
active_for_bus_year_fg BOOL NOT NULL
OPTIONS(description='An indicator showing whether the related exchange rate is, in principle, active for an entire business year.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (exchange_rate_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the ways in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ...');