CREATE TABLE P_LEW_CORE.T_PAYOUT_CURRENCY_EXCHANGE_RATE_2 (
   cy_month                            NUMBER(38,0)     NOT NULL COMMENT 'YYYYMM; WAWI: x_data.t_cal_month.cy_month',
   src_curr_cd                         VARCHAR(3)       NOT NULL COMMENT 'A code for currency from which the conversion rate is set.',
   tgt_curr_cd                         VARCHAR(3)       NOT NULL COMMENT 'A code for currency to which the conversion rate is set.',
   exchange_rate                       NUMBER(38,5)     COMMENT 'Exchange rate value.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PAYOUT_CURRENCY_EXCHANGE_RATE PRIMARY KEY (cy_month, src_curr_cd, tgt_curr_cd) NOT ENFORCED 
)  COMMENT = 'Agreed exchange rate for the payouts.';
