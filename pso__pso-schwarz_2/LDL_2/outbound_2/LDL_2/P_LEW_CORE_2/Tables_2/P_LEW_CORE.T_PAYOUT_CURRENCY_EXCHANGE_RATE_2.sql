CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_payout_currency_exchange_rate_2 (
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='YYYYMM; WAWI: x_data.t_cal_month.cy_month'),
src_curr_cd STRING(3) NOT NULL OPTIONS(description='A code for currency from which the conversion rate is set.'),
tgt_curr_cd STRING(3) NOT NULL OPTIONS(description='A code for currency to which the conversion rate is set.'),
exchange_rate BIGNUMERIC(38,5) OPTIONS(description='Exchange rate value.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (cy_month, src_curr_cd, tgt_curr_cd) NOT ENFORCED
) OPTIONS(description='Agreed exchange rate for the payouts.');