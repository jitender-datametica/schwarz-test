CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_currency_exchange_rate_1 (
from_curr_cd STRING(5) NOT NULL OPTIONS(description='The code identifying the source currency according to ISO-4217.'),
to_curr_cd STRING(5) NOT NULL OPTIONS(description='The code identifying the target currency according to ISO-4217.'),
curr_exchange_rate_type_cd STRING(5) NOT NULL
OPTIONS(description='The code identifying the way in which one currency can be converted into another.'),
active_from_dt DATE NOT NULL
OPTIONS(description='The first date from when this record became valid from a business perspective, i.e. the date from when on this exchange rate was used (inclusively).'),
active_to_dt DATE
OPTIONS(description='The last date up to when this record was valid from a business perspective, i.e. the date up to when this exchange rate was used (inclusively).'),
active_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt.'),
exchange_rate NUMERIC(9,5)
OPTIONS(description='The factor by which the amount in the source currency (from_curr_cd) needs to be multiplied, so that the result is in the target currency (to_curr_cd).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (from_curr_cd, to_curr_cd, curr_exchange_rate_type_cd, active_from_dt) NOT ENFORCED
)
OPTIONS(description='Currency exchange rates. For a given pair of currencies there might be several exchange rate types. Some of them might be valid for an entire business year.');