-- =====================================
-- T_DIM_CURRENCY_1
-- =====================================


CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_currency_1 (
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
curr_name STRING(100) NOT NULL OPTIONS(description='The name for the currency in group language, i.e. in German.'),
curr_name_de STRING(100) OPTIONS(description='The name for the currency in german.'),
curr_name_en STRING(100) OPTIONS(description='The name for the currency in english.'),
used_in_stores_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this currency is used in a country_1 where the Schwarz Group operates any stores.'),
euro_exch_rate BIGNUMERIC(38,6)
OPTIONS(description='The current exchange rate of this currency to the group currency (Euro). (These exchange rates are fixed once per business year.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (curr_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the currency codes according to ISO-4217. (E.g. EUR, USD, GBP, ...)');