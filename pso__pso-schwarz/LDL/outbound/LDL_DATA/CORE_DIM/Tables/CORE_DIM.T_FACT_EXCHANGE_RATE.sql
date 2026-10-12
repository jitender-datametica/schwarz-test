CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_fact_exchange_rate (
src_curr_cd STRING(3) NOT NULL
OPTIONS(description='The code according to ISO-4217, identifying the currency that is to be converted.'),
tgt_curr_cd STRING(3) NOT NULL
OPTIONS(description='The code according to ISO-4217, identifying the currency into which the source currency is to be converted.'),
exchange_rate_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way in which one currency can be converted into another.'),
active_from_dt DATE NOT NULL
OPTIONS(description='The first date from when this record became valid from a business perspective, i.e. the date from when on this exchange rate was used (inclusively).'),
active_to_dt DATE NOT NULL
OPTIONS(description='The last date up to when this record was valid from a business perspective, i.e. the date up to when this exchange rate was used (inclusively).'),
active_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt.'),
bus_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Some exchange rates are considered valid for an entire business year. If this is the case, this is the business year.'),
exchange_rate BIGNUMERIC(38,6) NOT NULL
OPTIONS(description='The factor by which the amount in the source currency (from_curr_cd) needs to be multiplied, so that the result is in the target currency (to_curr_cd).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (src_curr_cd, tgt_curr_cd, exchange_rate_type_cd, active_from_dt) NOT ENFORCED
)
OPTIONS(description='Currency exchange rates. For a given pair of currencies there might be several exchange rate types. Some of them might be valid for an entire business year.');