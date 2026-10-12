/* --------------------------------------------------------------------------------
   DDL for table: t_retail_sales_record
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_retail_sales_record (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
retail_sales_record_id NUMERIC(20,0) NOT NULL
OPTIONS(description='Faktura; SAP-Retail: vbrk.vbeln; SAP-BW: t_bw_2lis_13_vditm.vbeln '),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Belegwaehrung; FK auf CURRENCY; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk'),
curr_cd STRING(20) OPTIONS(description='Belegwaehrung - Code; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk'),
invoice_class_cd STRING(20)
OPTIONS(description='Fakturaart: ZF91=Umlagerung, ZFPM=LidlZahl.mittel, ZFPU=LidlUmsatz, ZS01=Umlagerung S; SAP-Retail: vbrk.fkart; SAP-BW: t_bw_2lis_13_vditm.fkart; ELWIS: invoice_art_cd'),
invoice_type_cd STRING(20)
OPTIONS(description='Fakturatyp: W=POS-Faktura, L=Lieferbezogene Faktura,...; SAP-Retail: vbrk.fktyp; SAP-BW: t_bw_2lis_13_vditm.fktyp; ELWIS: invoice_type_cd'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Fakturadatum; SAP-Retail: vbrk.fkdat; SAP-BW: t_bw_2lis_13_vditm.fkdat; ELWIS: invoice_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, retail_sales_record_id) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. RESA; Faktura(Kopfdaten);             SAP-Retail: vbrk;             SAP-BW: t_bw_2lis_13_vditm;             ELWIS: t_s_retail_sales_record');