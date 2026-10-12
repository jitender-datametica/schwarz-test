/* --------------------------------------------------------------------------------
   DDL for table: t_pos_agg_bon_cnts_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_agg_bon_cnts_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Filiale; FK auf LOCATION_2; SAP-CAR: z_ds_zpdx_aggr1a_mis.retailstoreid'),
aggr_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des POS-Aggregats; SAP-CAR: z_ds_zpdx_aggr1a_mis.aggr_no'),
cnt_receipts_sales BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Bon Sales_2/Mix; SAP-CAR: z_ds_zpdx_aggr1a_mis.ta_count_s; ELWIS: bon_cnt_sales'),
cnt_receipts_returns BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Bon Retouren; SAP-CAR: z_ds_zpdx_aggr1a_mis.ta_count_r; ELWIS: bon_cnt_returns'),
cnt_receiptlines_total BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Bon Positionen; SAP-CAR: z_ds_zpdx_aggr1a_mis.lineitemcount; ELWIS: bon_pos_cnt_total'),
cnt_receiptlines_sales BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Bon Positionen Sales_2/Mix; SAP-CAR: z_ds_zpdx_aggr1a_mis.ta_pos_count_s; ELWIS: bon_pos_cnt_sales'),
cnt_receiptlines_returns BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Bon Positionen Retouren; SAP-CAR: z_ds_zpdx_aggr1a_mis.ta_pos_count_r; ELWIS: bon_pos_cnt_returns'),
trans_start_tmsp DATETIME NOT NULL
OPTIONS(description='Transaktion Start; SAP-CAR: z_ds_zpdx_aggr1a_mis.tran_ts_min; ELWIS: trans_start_dts'),
trans_end_tmsp DATETIME
OPTIONS(description='Transaktion Ende; SAP-CAR: z_ds_zpdx_aggr1a_mis.tran_ts_max; ELWIS: trans_end_dts'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Buchungsdatum; SAP-CAR: z_ds_zpdx_aggr1a_mis.businessdaydate; ELWIS: bus_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid, aggr_nr, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. POS-Summensatz (Bonzahler) [Filiale, Tag_2];             SAP CAR: z_ds_zpdx_aggr1a_mis;             ELWIS: t_s_bon_cnts_car');