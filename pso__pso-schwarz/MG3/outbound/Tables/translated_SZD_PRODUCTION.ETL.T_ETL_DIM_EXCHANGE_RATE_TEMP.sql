CREATE OR REPLACE TABLE szd_production_etl.t_etl_dim_exchange_rate_temp (
dwh_valid_from_dt DATE NOT NULL OPTIONS(description='The date when this record became valid.'),
dwh_valid_to_dt DATE NOT NULL OPTIONS(description='The date when this record was no longer valid.'),
active_from_dt DATE NOT NULL
OPTIONS(description='The first date from when this record became valid from a business perspective, i.e. the date from when on this exchange rate was used (inclusively).'),
active_to_dt DATE NOT NULL
OPTIONS(description='The last date up to when this record was valid from a business perspective, i.e. the date up to when this exchange rate was used (inclusively).'),
curr_cd_from STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
curr_cd_to STRING(3) NOT NULL OPTIONS(description='The code identifying the target currency according to ISO-4217.'),
exchange_rate NUMERIC(29,5)
OPTIONS(description='The current exchange rate of this currency to the group currency (Euro). (These exchange rates are fixed once per business year.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (dwh_valid_from_dt, active_from_dt, curr_cd_from, curr_cd_to) NOT ENFORCED
);