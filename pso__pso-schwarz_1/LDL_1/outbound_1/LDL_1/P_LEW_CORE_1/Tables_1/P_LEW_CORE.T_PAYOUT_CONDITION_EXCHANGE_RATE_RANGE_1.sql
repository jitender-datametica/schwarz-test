CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_payout_condition_exchange_rate_range_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
sup_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SUPPLIER_1'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key ITEM_1 (unique across all countries / clients).'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Invoice currency; FK on CURRENCY; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk'),
curr_iso_cd STRING(3) OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'),
exchange_rate_cond_start_dt DATE NOT NULL OPTIONS(description='Start date of curreny condition validity.'),
exchange_rate_cond_end_dt DATE OPTIONS(description='End date of curreny condition validity.'),
min_exchange_rate BIGNUMERIC(38,5) NOT NULL OPTIONS(description='The minimum value for an exchange rate.'),
max_exchange_rate BIGNUMERIC(38,5) OPTIONS(description='The maximum value for an exchange rate.'),
payout_cond_net_val BIGNUMERIC(38,5) OPTIONS(description='An amount that should be billed, netto in given currency.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (sup_sid, item_sid, exchange_rate_cond_start_dt, min_exchange_rate) NOT ENFORCED
)
OPTIONS(description='Exchange rate conditions for the payouts (Bandbreite). Specifies what payout value to use depending on the exchange rate at the moment of the payout.');