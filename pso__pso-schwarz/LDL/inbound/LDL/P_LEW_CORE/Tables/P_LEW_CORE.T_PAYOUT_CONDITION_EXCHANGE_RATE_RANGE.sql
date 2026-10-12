CREATE TABLE P_LEW_CORE.T_PAYOUT_CONDITION_EXCHANGE_RATE_RANGE (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   sup_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SUPPLIER',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM (unique across all countries / clients).',
   curr_sid                            NUMBER(38,0)     COMMENT 'Invoice currency; FK on CURRENCY; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk',
   curr_iso_cd                         VARCHAR(3)       COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd',
   exchange_rate_cond_start_dt         DATE             NOT NULL COMMENT 'Start date of curreny condition validity.',
   exchange_rate_cond_end_dt           DATE             COMMENT 'End date of curreny condition validity.',
   min_exchange_rate                   NUMBER(38,5)     NOT NULL COMMENT 'The minimum value for an exchange rate.',
   max_exchange_rate                   NUMBER(38,5)     COMMENT 'The maximum value for an exchange rate.',
   payout_cond_net_val                 NUMBER(38,5)     COMMENT 'An amount that should be billed, netto in given currency.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PAYOUT_CONDITION_EXCHANGE_RATE_RANGE PRIMARY KEY (sup_sid, item_sid, exchange_rate_cond_start_dt, min_exchange_rate) NOT ENFORCED 
)  COMMENT = 'Exchange rate conditions for the payouts (Bandbreite). Specifies what payout value to use depending on the exchange rate at the moment of the payout.';
