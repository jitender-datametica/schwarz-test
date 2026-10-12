/* --------------------------------------------------------------------------------
   DDL for table: t_pos_agg_bon_cnts_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_POS_AGG_BON_CNTS_1 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Filiale; FK auf LOCATION_1; SAP-CAR: z_ds_zpdx_aggr1a_mis.retailstoreid',
   aggr_nr                             NUMBER(38,0)     NOT NULL COMMENT 'Nummer des POS-Aggregats; SAP-CAR: z_ds_zpdx_aggr1a_mis.aggr_no',
   cnt_receipts_sales                  NUMBER(38,0)     COMMENT 'Anzahl Bon Sales_1/Mix; SAP-CAR: z_ds_zpdx_aggr1a_mis.ta_count_s; ELWIS: bon_cnt_sales',
   cnt_receipts_returns                NUMBER(38,0)     COMMENT 'Anzahl Bon Retouren; SAP-CAR: z_ds_zpdx_aggr1a_mis.ta_count_r; ELWIS: bon_cnt_returns',
   cnt_receiptlines_total              NUMBER(38,0)     COMMENT 'Anzahl Bon Positionen; SAP-CAR: z_ds_zpdx_aggr1a_mis.lineitemcount; ELWIS: bon_pos_cnt_total',
   cnt_receiptlines_sales              NUMBER(38,0)     COMMENT 'Anzahl Bon Positionen Sales_1/Mix; SAP-CAR: z_ds_zpdx_aggr1a_mis.ta_pos_count_s; ELWIS: bon_pos_cnt_sales',
   cnt_receiptlines_returns            NUMBER(38,0)     COMMENT 'Anzahl Bon Positionen Retouren; SAP-CAR: z_ds_zpdx_aggr1a_mis.ta_pos_count_r; ELWIS: bon_pos_cnt_returns',
   trans_start_tmsp                    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Transaktion Start; SAP-CAR: z_ds_zpdx_aggr1a_mis.tran_ts_min; ELWIS: trans_start_dts',
   trans_end_tmsp                      TIMESTAMP_NTZ(9) COMMENT 'Transaktion Ende; SAP-CAR: z_ds_zpdx_aggr1a_mis.tran_ts_max; ELWIS: trans_end_dts',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Buchungsdatum; SAP-CAR: z_ds_zpdx_aggr1a_mis.businessdaydate; ELWIS: bus_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_POS_AGG_BON_CNTS PRIMARY KEY (loc_sid, aggr_nr, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. POS-Summensatz (Bonzahler) [Filiale, Tag_1];
             SAP CAR: z_ds_zpdx_aggr1a_mis;
             ELWIS: t_s_bon_cnts_car';

