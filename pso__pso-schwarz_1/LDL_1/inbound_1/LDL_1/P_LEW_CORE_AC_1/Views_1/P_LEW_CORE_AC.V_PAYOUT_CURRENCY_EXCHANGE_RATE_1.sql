CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_PAYOUT_CURRENCY_EXCHANGE_RATE_1 (
   cy_month                                 COMMENT 'YYYYMM; WAWI: x_data.t_cal_month.cy_month'
  ,src_curr_cd                              COMMENT 'A code for currency from which the conversion rate is set.'
  ,tgt_curr_cd                              COMMENT 'A code for currency to which the conversion rate is set.'
  ,exchange_rate                            COMMENT 'Exchange rate value.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Agreed exchange rate for the payouts.'
AS SELECT
   cy_month
  ,src_curr_cd
  ,tgt_curr_cd
  ,exchange_rate
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_PAYOUT_CURRENCY_EXCHANGE_RATE_1
;