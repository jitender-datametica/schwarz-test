/* --------------------------------------------------------------------------------
   DDL for table: t_sales_invoice_record_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_sales_invoice_record_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
sales_invoice_record_cd STRING(20) NOT NULL
OPTIONS(description='Faktura; SAP-Retail: vbrk.vbeln; SAP-BW: t_bw_2lis_13_vditm.vbeln '),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Belegwaehrung; FK auf CURRENCY; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk'),
sales_org_sid BIGNUMERIC(38,0)
OPTIONS(description='Verkaufsorganisation; FK auf SALES_ORG; SAP-Retail: vbrk.vkorg; SAP-BW: t_bw_2lis_13_vditm.vkorg'),
country_pol_sid_delivery BIGNUMERIC(38,0)
OPTIONS(description='Beliefertes Land_1; FK auf COUNTRY_POLITICAL; SAP-Retail: vbrk.land1; SAP-BW: t_bw_2lis_13_vditm.land1'),
country_pol_cd_delivery STRING(20)
OPTIONS(description='Beliefertes Land_1 - Code; SAP-Retail: vbrk.land1; SAP-BW: t_bw_2lis_13_vditm.land1'),
invoice_class_cd STRING(20)
OPTIONS(description='Fakturaart: ZF91=Umlagerung_1, ZFPM=LidlZahl.mittel, ZFPU=LidlUmsatz, ZS01=Umlagerung_1 S; SAP-Retail: vbrk.fkart; SAP-BW: t_bw_2lis_13_vditm.fkart; ELWIS: invoice_art_cd'),
invoice_type_cd STRING(20)
OPTIONS(description='Fakturatyp: W=POS-Faktura, L=Lieferbezogene Faktura,...; SAP-Retail: vbrk.fktyp; SAP-BW: t_bw_2lis_13_vditm.fktyp; ELWIS: invoice_type_cd'),
curr_cd STRING(20) OPTIONS(description='Belegwaehrung - Code; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk'),
net_total_val NUMERIC(18,5)
OPTIONS(description='Nettowert in Belegwaehrung; SAP-Retail: vbrk.netwr; SAP-BW: t_bw_2lis_13_vditm.netwr'),
ref_sales_invoice_record_cd STRING(20)
OPTIONS(description='Zahlungsreferenz: Referenz auf Originalbeleg: abweichend von retail_sales_record_id im Falle einer Stornierung; SAP-Retail: vbrk.kidno; SAP-Retail: vbrk.kidno; SAP-BW: t_bw_2lis_13_vditm.kidno'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Fakturadatum; SAP-Retail: vbrk.fkdat; SAP-BW: t_bw_2lis_13_vditm.fkdat; ELWIS: invoice_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, sales_invoice_record_cd) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. RESA; Faktura(Kopfdaten);              nur Belege mit Gesamtbearbeitungsstatus "vollstaendig bearbeitet" (VBUK.GBSTK="C")             SAP-Retail: vbrk;             SAP-BW: t_bw_2lis_13_vditm;             ELWIS: t_s_retail_sales_record');