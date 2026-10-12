/* --------------------------------------------------------------------------------
   DDL for table: t_retail_sales_record_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_RETAIL_SALES_RECORD_1 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   retail_sales_record_id              NUMBER(20,0)     NOT NULL COMMENT 'Faktura; SAP-Retail: vbrk.vbeln; SAP-BW: t_bw_2lis_13_vditm.vbeln ',
   curr_sid                            NUMBER(38,0)     COMMENT 'Belegwaehrung; FK auf CURRENCY; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk',
   curr_cd                             VARCHAR(20)      COMMENT 'Belegwaehrung - Code; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk',
   invoice_class_cd                    VARCHAR(20)      COMMENT 'Fakturaart: ZF91=Umlagerung_1, ZFPM=LidlZahl.mittel, ZFPU=LidlUmsatz, ZS01=Umlagerung_1 S; SAP-Retail: vbrk.fkart; SAP-BW: t_bw_2lis_13_vditm.fkart; ELWIS: invoice_art_cd',
   invoice_type_cd                     VARCHAR(20)      COMMENT 'Fakturatyp: W=POS-Faktura, L=Lieferbezogene Faktura,...; SAP-Retail: vbrk.fktyp; SAP-BW: t_bw_2lis_13_vditm.fktyp; ELWIS: invoice_type_cd',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Fakturadatum; SAP-Retail: vbrk.fkdat; SAP-BW: t_bw_2lis_13_vditm.fkdat; ELWIS: invoice_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_RETAIL_SALES_RECORD PRIMARY KEY (client_id, retail_sales_record_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. RESA; Faktura(Kopfdaten);
             SAP-Retail: vbrk;
             SAP-BW: t_bw_2lis_13_vditm;
             ELWIS: t_s_retail_sales_record';

