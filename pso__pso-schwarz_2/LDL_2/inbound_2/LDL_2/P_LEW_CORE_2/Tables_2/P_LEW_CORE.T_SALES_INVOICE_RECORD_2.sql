/* --------------------------------------------------------------------------------
   DDL for table: t_sales_invoice_record_2
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SALES_INVOICE_RECORD_2 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   sales_invoice_record_cd             VARCHAR(20)      NOT NULL COMMENT 'Faktura; SAP-Retail: vbrk.vbeln; SAP-BW: t_bw_2lis_13_vditm.vbeln ',
   curr_sid                            NUMBER(38,0)     COMMENT 'Belegwaehrung; FK auf CURRENCY; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk',
   sales_org_sid                       NUMBER(38,0)     COMMENT 'Verkaufsorganisation; FK auf SALES_ORG; SAP-Retail: vbrk.vkorg; SAP-BW: t_bw_2lis_13_vditm.vkorg',
   country_pol_sid_delivery            NUMBER(38,0)     COMMENT 'Beliefertes Land_2; FK auf COUNTRY_POLITICAL; SAP-Retail: vbrk.land1; SAP-BW: t_bw_2lis_13_vditm.land1',
   country_pol_cd_delivery             VARCHAR(20)      COMMENT 'Beliefertes Land_2 - Code; SAP-Retail: vbrk.land1; SAP-BW: t_bw_2lis_13_vditm.land1',
   invoice_class_cd                    VARCHAR(20)      COMMENT 'Fakturaart: ZF91=Umlagerung_2, ZFPM=LidlZahl.mittel, ZFPU=LidlUmsatz, ZS01=Umlagerung_2 S; SAP-Retail: vbrk.fkart; SAP-BW: t_bw_2lis_13_vditm.fkart; ELWIS: invoice_art_cd',
   invoice_type_cd                     VARCHAR(20)      COMMENT 'Fakturatyp: W=POS-Faktura, L=Lieferbezogene Faktura,...; SAP-Retail: vbrk.fktyp; SAP-BW: t_bw_2lis_13_vditm.fktyp; ELWIS: invoice_type_cd',
   curr_cd                             VARCHAR(20)      COMMENT 'Belegwaehrung - Code; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk',
   net_total_val                       NUMBER(18,5)     COMMENT 'Nettowert in Belegwaehrung; SAP-Retail: vbrk.netwr; SAP-BW: t_bw_2lis_13_vditm.netwr',
   ref_sales_invoice_record_cd         VARCHAR(20)      COMMENT 'Zahlungsreferenz: Referenz auf Originalbeleg: abweichend von retail_sales_record_id im Falle einer Stornierung; SAP-Retail: vbrk.kidno; SAP-Retail: vbrk.kidno; SAP-BW: t_bw_2lis_13_vditm.kidno',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Fakturadatum; SAP-Retail: vbrk.fkdat; SAP-BW: t_bw_2lis_13_vditm.fkdat; ELWIS: invoice_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SALES_INVOICE_RECORD PRIMARY KEY (client_id, sales_invoice_record_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. RESA; Faktura(Kopfdaten); 
             nur Belege mit Gesamtbearbeitungsstatus "vollstaendig bearbeitet" (VBUK.GBSTK="C")
             SAP-Retail: vbrk;
             SAP-BW: t_bw_2lis_13_vditm;
             ELWIS: t_s_retail_sales_record';

