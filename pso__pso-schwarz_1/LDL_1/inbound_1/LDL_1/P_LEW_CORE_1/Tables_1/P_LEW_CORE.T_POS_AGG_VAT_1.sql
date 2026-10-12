/* --------------------------------------------------------------------------------
   DDL for table: t_pos_agg_vat_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_POS_AGG_VAT_1 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   aggr_nr                             NUMBER(38,0)     NOT NULL COMMENT 'Nummer des POS-Aggregats; SAP-CAR: z_ds_zpdx_aggr31_mis.aggr_no; ELWIS: t_s_aggr31_mis_vat.aggr_nr',
   aggr_rec_nr                         NUMBER(38,0)     NOT NULL COMMENT 'Nummer des Aggregationssatzes innerhalb der Gruppe_1; SAP-CAR: z_ds_zpdx_aggr31_mis.record_no; ELWIS: t_s_aggr31_mis_vat.aggr_rec_nr',
   curr_sid                            NUMBER(38,0)     COMMENT 'Transaktionswaehrung; FK auf CURRENCY; SAP-CAR: z_ds_zpdx_aggr31_mis.currency; ELWIS: t_s_aggr31_mis_vat.trans_curr',
   curr_cd                             VARCHAR(20)      NOT NULL COMMENT 'Transaktionswaehrung; SAP-CAR: z_ds_zpdx_aggr31_mis.currency; ELWIS: t_s_aggr31_mis_vat.trans_curr',
   tax_type_cd                         VARCHAR(20)      NOT NULL COMMENT 'Typ fur Steuern (Steuerarten) - Codes selbst sind in POS DTA im Customizing gepflegt; SAP-CAR: z_ds_zpdx_aggr31_mis.taxtypecode; ELWIS: t_s_aggr31_mis_vat.tax_type_cd',
   tax_val                             NUMBER(18,5)     COMMENT 'Wert des Steuertyps; SAP-CAR: z_ds_zpdx_aggr31_mis.taxsaleamt; ELWIS: t_s_aggr31_mis_vat.tax_sales_amt',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Datum Tagesabschluss; SAP-CAR: z_ds_zpdx_aggr31_mis.day_end_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_POS_AGG_VAT PRIMARY KEY (client_id, aggr_nr, aggr_rec_nr, tax_type_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. POS-Aggregat Steuerdaten [Steuertyp, Wahrung];
             SAP CAR: z_ds_zpdx_aggr31_mis;
             ELWIS: t_s_aggr31_mis_vat';

