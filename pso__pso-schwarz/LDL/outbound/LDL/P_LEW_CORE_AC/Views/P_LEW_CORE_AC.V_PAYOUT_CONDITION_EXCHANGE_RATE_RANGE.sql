CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_payout_condition_exchange_rate_range (client_id
OPTIONS(description='DWH-Mandant; FK auf CLIENT'), sup_sid OPTIONS(description='Surrogate Key SUPPLIER'), item_sid
OPTIONS(description='Surrogate Key ITEM (unique across all countries / clients).'), curr_sid
OPTIONS(description='Invoice currency; FK on CURRENCY; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk'),
curr_iso_cd OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'),
exchange_rate_cond_start_dt OPTIONS(description='Start date of curreny condition validity.'), exchange_rate_cond_end_dt
OPTIONS(description='End date of curreny condition validity.'), min_exchange_rate
OPTIONS(description='The minimum value for an exchange rate.'), max_exchange_rate
OPTIONS(description='The maximum value for an exchange rate.'), payout_cond_net_val
OPTIONS(description='An amount that should be billed, netto in given currency.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `EXCHANGE RATE CONDITIONS FOR THE PAYOUTS (BANDBREITE). SPECIFIES WHAT PAYOUT VALUE TO USE DEPENDING ON THE EXCHANGE RATE AT THE MOMENT OF THE PAYOUT.`)
AS SELECT client_id,
 sup_sid,
 item_sid,
 curr_sid,
 curr_iso_cd,
 exchange_rate_cond_start_dt,
 exchange_rate_cond_end_dt,
 min_exchange_rate,
 max_exchange_rate,
 payout_cond_net_val,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_payout_condition_exchange_rate_range;