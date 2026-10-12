CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_payout_currency_exchange_rate_2 (cy_month
OPTIONS(description='YYYYMM; WAWI: x_data.t_cal_month.cy_month'), src_curr_cd
OPTIONS(description='A code for currency from which the conversion rate is set.'), tgt_curr_cd
OPTIONS(description='A code for currency to which the conversion rate is set.'), exchange_rate
OPTIONS(description='Exchange rate value.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `AGREED EXCHANGE RATE FOR THE PAYOUTS.`) AS SELECT cy_month,
 src_curr_cd,
 tgt_curr_cd,
 exchange_rate,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_payout_currency_exchange_rate_2;