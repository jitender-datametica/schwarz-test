/* --------------------------------------------------------------------------------
   DDL for table: t_sales_delivery_2
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SALES_DELIVERY_2 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   sales_invoice_record_cd             VARCHAR(20)      NOT NULL COMMENT 'Faktura; SAP-Retail: vbrp.vbeln; SAP-BW: t_bw_2lis_13_vditm.vbeln; ELWIS: t_s_retail_sales_record_pos.sales_rec_nr',
   sales_invoice_record_pos_id         NUMBER(38,0)     NOT NULL COMMENT 'Fakturaposition; SAP-Retail: vbrp.posnr; SAP-BW: t_bw_2lis_13_vditm.posnr; ELWIS: t_s_retail_sales_record_pos.sales_rec_pos_nr',
   sales_org_sid                       NUMBER(38,0)     COMMENT 'Verkaufsorganisation; FK auf SALES_ORG; SAP-Retail: vbrk.vkorg; SAP-BW: t_bw_2lis_13_vditm.vkorg',
   country_pol_sid_delivery            NUMBER(38,0)     COMMENT 'Beliefertes Land_2; FK auf COUNTRY_POLITICAL; SAP-Retail: vbrk.land1; SAP-BW: t_bw_2lis_13_vditm.land1',
   country_pol_sid_send                NUMBER(38,0)     COMMENT 'Lieferndes Land_2; SAP-Retail: vbrp.aland; SAP-BW: t_bw_2lis_13_vditm.aland',
   country_pol_cd_delivery             VARCHAR(20)      COMMENT 'Beliefertes Land_2 - Code; SAP-Retail: vbrk.land1; SAP-BW: t_bw_2lis_13_vditm.land1',
   country_pol_cd_send                 VARCHAR(20)      COMMENT 'Lieferndes Land_2 - Code; SAP-Retail: vbrp.aland; SAP-BW: t_bw_2lis_13_vditm.aland',
   invoice_class_cd                    VARCHAR(20)      COMMENT 'Fakturaart: ZF91=Umlagerung_2, ZFPM=LidlZahl.mittel, ZFPU=LidlUmsatz, ZS01=Umlagerung_2 S; SAP-Retail: vbrk.fkart; SAP-BW: t_bw_2lis_13_vditm.fkart; ELWIS: invoice_art_cd',
   invoice_type_cd                     VARCHAR(20)      COMMENT 'Fakturatyp: W=POS-Faktura, L=Lieferbezogene Faktura,...; SAP-Retail: vbrk.fktyp; SAP-BW: t_bw_2lis_13_vditm.fktyp; ELWIS: invoice_type_cd',
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
   cond_subtotal_3                     NUMBER(18,5)     COMMENT 'Konditionszwischensumme 3 aus Kalkulationsschema; SAP-Retail: vbrp.kzwi3; SAP-BW: t_bw_2lis_13_vditm.kzwi3; ELWIS: t_s_retail_sales_record_pos.gross_calc3_sales_amt',
   cond_subtotal_4                     NUMBER(18,5)     COMMENT 'Konditionszwischensumme 4 aus Kalkulationsschema; SAP-Retail: vbrp.kzwi4; SAP-BW: t_bw_2lis_13_vditm.kzwi4; ELWIS: t_s_retail_sales_record_pos.gross_calc4_sales_amt',
   cond_subtotal_5                     NUMBER(18,5)     COMMENT 'Konditionszwischensumme 5 aus Kalkulationsschema; SAP-Retail: vbrp.kzwi5; SAP-BW: t_bw_2lis_13_vditm.kzwi5; ELWIS: t_s_retail_sales_record_pos.gross_calc5_sales_amt',
   cond_subtotal_6                     NUMBER(18,5)     COMMENT 'Konditionszwischensumme 6 aus Kalkulationsschema; SAP-Retail: vbrp.kzwi6; SAP-BW: t_bw_2lis_13_vditm.kzwi6; ELWIS: t_s_retail_sales_record_pos.gross_calc6_sales_amt',
   sales_invoice_dt                    DATE             COMMENT 'Rechnungsdatum; SAP-Retail: vbrk.fkdat; SAP-BW: t_bw_2lis_13_vditm.fkdat',
   sales_delivery_dt                   DATE             COMMENT 'Buchungsdatum des Warenausgangs; SAP-Retail: vbrp.fbuda; SAP-BW: t_bw_2lis_13_vditm.fbuda',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'VORLAEUFIG (ersetzt durch salesdelivery_dt) Verkaufsdatum/Fakruradatum/Rechnungdatum; SAP-Retail: vbrk.FKDAT; SAP-BW: t_bw_2lis_13_vditm.fkdat; ELWIS: invoice_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SALES_DELIVERY PRIMARY KEY (client_id, sales_invoice_record_cd, sales_invoice_record_pos_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. RESP; Faktura - Positionsdaten;
             SAP-Retail: vbrp (&vbrk);
             SAP-BW: t_bw_2lis_13_vditm;
             ELWIS: t_s_retail_sales_record_pos';

