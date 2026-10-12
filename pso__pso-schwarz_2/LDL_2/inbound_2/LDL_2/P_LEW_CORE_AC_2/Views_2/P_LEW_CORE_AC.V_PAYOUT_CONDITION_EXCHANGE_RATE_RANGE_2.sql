CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_PAYOUT_CONDITION_EXCHANGE_RATE_RANGE_2 (
   client_id                                COMMENT 'DWH-Mandant_2; FK auf CLIENT'
  ,sup_sid                                  COMMENT 'Surrogate Key SUPPLIER_2'
  ,item_sid                                 COMMENT 'Surrogate Key ITEM_2 (unique across all countries / clients).'
  ,curr_sid                                 COMMENT 'Invoice currency; FK on CURRENCY; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk'
  ,curr_iso_cd                              COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'
  ,exchange_rate_cond_start_dt              COMMENT 'Start date of curreny condition validity.'
  ,exchange_rate_cond_end_dt                COMMENT 'End date of curreny condition validity.'
  ,min_exchange_rate                        COMMENT 'The minimum value for an exchange rate.'
  ,max_exchange_rate                        COMMENT 'The maximum value for an exchange rate.'
  ,payout_cond_net_val                      COMMENT 'An amount that should be billed, netto in given currency.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Exchange rate conditions for the payouts (Bandbreite). Specifies what payout value to use depending on the exchange rate at the moment of the payout.'
AS SELECT
   client_id
  ,sup_sid
  ,item_sid
  ,curr_sid
  ,curr_iso_cd
  ,exchange_rate_cond_start_dt
  ,exchange_rate_cond_end_dt
  ,min_exchange_rate
  ,max_exchange_rate
  ,payout_cond_net_val
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_PAYOUT_CONDITION_EXCHANGE_RATE_RANGE_2
;