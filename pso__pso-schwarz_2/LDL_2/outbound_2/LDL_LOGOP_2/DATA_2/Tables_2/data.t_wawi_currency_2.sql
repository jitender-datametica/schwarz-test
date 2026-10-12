CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_currency_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
client_desc STRING(18) OPTIONS(description='Country_2 name'),
curr_name STRING(18) OPTIONS(description='Currency name'),
curr_ticker STRING(18) OPTIONS(description='Currency ticker'),
curr_sign STRING(18) OPTIONS(description='Currency sign')
) OPTIONS(description='WAWI - Country_2 and Currency Mapping');