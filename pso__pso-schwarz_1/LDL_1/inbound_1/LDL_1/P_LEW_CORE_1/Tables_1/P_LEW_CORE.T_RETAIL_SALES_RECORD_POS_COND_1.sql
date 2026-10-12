/* --------------------------------------------------------------------------------
   DDL for table: t_retail_sales_record_pos_cond_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_RETAIL_SALES_RECORD_POS_COND_1 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   retail_sales_record_id              NUMBER(20,0)     NOT NULL COMMENT 'Faktura; SAP-BW: t_bw_2lis_13_vdkon.vbeln; ELWIS: t_s_retail_sales_rec_pos_cond.sales_rec_nr',
   retail_sales_record_pos_id          NUMBER(38,0)     NOT NULL COMMENT 'Fakturaposition; SAP-BW: t_bw_2lis_13_vdkon.posnr; ELWIS: t_s_retail_sales_rec_pos_cond.sales_rec_pos_nr',
   cond_type_cd                        VARCHAR(20)      NOT NULL COMMENT 'Konditionsart; SAP-BW: t_bw_2lis_13_vdkon.kschl; ELWIS: t_s_retail_sales_rec_pos_cond.cond_type_cd',
   cond_rec_id                         NUMBER(38,0)     NOT NULL COMMENT 'Zahler Konditionen; SAP-BW: t_bw_2lis_13_vdkon.zaehk; ELWIS: t_s_retail_sales_rec_pos_cond.cond_rec_id',
   curr_sid                            NUMBER(38,0)     COMMENT 'Wahrung; FK auf CURRENCY; SAP-BW; t_bw_2lis_13_vdkon.WAERS; ELWIS: curr_sid',
   uom_sid                             NUMBER(38,0)     COMMENT 'Basis-Mengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-BW: t_bw_2lis_13_vdkon.MEINS',
   curr_cd                             VARCHAR(20)      COMMENT 'Wahrungscode; SAP-BW; t_bw_2lis_13_vdkon.WAERS; ELWIS: curr_sid',
   cond_val                            NUMBER(18,5)     COMMENT 'Konditionsbetrag; SAP-BW: t_bw_2lis_13_vdkon.KBETR; ELWIS: cond_sales_amt',
   gross_val                           NUMBER(18,5)     COMMENT 'Bruttobetrag der Fakturaposition; SAP-BW: t_bw_2lis_13_vdkon.KAWRT;',
   tax_val                             NUMBER(18,5)     COMMENT 'Steuerbetrag; SAP-BW: t_bw_2lis_13_vdkon.MWSBP;',
   net_val                             NUMBER(18,5)     COMMENT 'Nettobetrag der Fakturaposition: total_sales_val - tax_sales_val',
   uom_cd                              VARCHAR(20)      COMMENT 'Basis-Mengeneinheit; SAP-BW: t_bw_2lis_13_vdkon.MEINS',
   act_qty                             NUMBER(18,5)     COMMENT 'Tatsachlich fakturierte Menge; SAP-BW: t_bw_2lis_13_vdkon.FKIMG',
   lme_qty                             NUMBER(18,5)     COMMENT 'Fakturamenge in LME; SAP-BW: t_bw_2lis_13_vdkon.FKLMG',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Verkaufsdatum/Fakruradatum/Rechnungdatum; SAP-BW: t_bw_2lis_13_vdkon.FKDAT; ELWIS: invoice_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_RETAIL_SALES_RECORD_POS_COND PRIMARY KEY (client_id, retail_sales_record_id, retail_sales_record_pos_id, cond_type_cd, cond_rec_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. RESC; Preisfindung Kommunikations-Konditionssatz;
             SAP-Retail: ?;
             SAP-BW: t_bw_2lis_13_vdkon;
             ELWIS: t_s_retail_sales_rec_pos_cond;
             WAWI: ';

