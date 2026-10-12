/* --------------------------------------------------------------------------------
   DDL for table: t_retail_sales_record_pos_2
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_RETAIL_SALES_RECORD_POS_2 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   retail_sales_record_id              NUMBER(20,0)     NOT NULL COMMENT 'Faktura; SAP-Retail: vbrp.vbeln; SAP-BW: t_bw_2lis_13_vditm.vbeln; ELWIS: t_s_retail_sales_record_pos.sales_rec_nr',
   retail_sales_record_pos_id          NUMBER(38,0)     NOT NULL COMMENT 'Fakturaposition; SAP-Retail: vbrp.posnr; SAP-BW: t_bw_2lis_13_vditm.posnr; ELWIS: t_s_retail_sales_record_pos.sales_rec_pos_nr',
   item_sid                            NUMBER(38,0)     COMMENT 'Artikel_2; FK auf ITEM_2; SAP-Retail: vbrp.matnr; SAP-BW: t_bw_2lis_13_vditm.matnr',
   loc_sid                             NUMBER(38,0)     COMMENT 'Betrieb; FK auf LOCATION_2; SAP-Retail: vbrp.werks; SAP-BW: t_bw_2lis_13_vditm.werks',
   uom_sid                             NUMBER(38,0)     COMMENT 'Verkaufsmengeneinheit; FK auf UNIT_2 OF MEASUREMENT; SAP-Retail: vbrp.vrkme; SAP-BW: t_bw_2lis_13_vditm.vrkme',
   curr_sid                            NUMBER(38,0)     COMMENT 'Belegwaehrung; FK auf CURRENCY; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk',
   uom_cd                              VARCHAR(20)      COMMENT 'Verkaufsmengeneinheit; SAP-Retail: vbrp.vrkme; SAP-BW: t_bw_2lis_13_vditm.vrkme',
   qty_act                             NUMBER(18,5)     COMMENT 'Tatsaechlich fakturierte Menge; SAP-Retail: vbrp.fkimg; SAP-BW: t_bw_2lis_13_vditm.fkimg; ELWIS: t_s_retail_sales_record_pos.qty_act',
   qty_stock_unit                      NUMBER(18,5)     COMMENT 'Verkaufsmenge in Lagermengeneinheit; SAP-Retail: vbrp.fklmg; SAP-BW: t_bw_2lis_13_vditm.fklmg; ELWIS: t_s_retail_sales_record_pos.qty_lme',
   curr_cd                             VARCHAR(20)      COMMENT 'Belegwaehrung - Code; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk',
   net_val                             NUMBER(18,5)     COMMENT 'Nettowert der Fakturaposition in Belegwaehrung; SAP-Retail: vbrp.netwr; SAP-BW: t_bw_2lis_13_vditm.netwr; ELWIS: t_s_retail_sales_record_pos.net_sales_amt',
   tax_val                             NUMBER(18,5)     COMMENT 'Steuerbetrag in Belegwaehrung; SAP-Retail: vbrp.mwsbp; SAP-BW: t_bw_2lis_13_vditm.mwsbp; ELWIS: t_s_retail_sales_record_pos.tax_sales_amt',
   cond_subtotal_1                     NUMBER(18,5)     COMMENT 'Konditionszwischensumme 1 aus Kalkulationsschema; SAP-Retail: vbrp.kzwi1; SAP-BW: t_bw_2lis_13_vditm.kzwi1; ELWIS: t_s_retail_sales_record_pos.gross_calc1_sales_amt',
   cond_subtotal_2                     NUMBER(18,5)     COMMENT 'Konditionszwischensumme 2 aus Kalkulationsschema; SAP-Retail: vbrp.kzwi2; SAP-BW: t_bw_2lis_13_vditm.kzwi2; ELWIS: t_s_retail_sales_record_pos.gross_calc2_sales_amt',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Verkaufsdatum/Fakruradatum/Rechnungdatum; SAP-Retail: vbrk.FKDAT; SAP-BW: t_bw_2lis_13_vditm.fkdat; ELWIS: invoice_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_RETAIL_SALES_RECORD_POS PRIMARY KEY (client_id, retail_sales_record_id, retail_sales_record_pos_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. RESP; Faktura - Positionsdaten;
             SAP-Retail: vbrp (&vbrk);
             SAP-BW: t_bw_2lis_13_vditm;
             ELWIS: t_s_retail_sales_record_pos';

