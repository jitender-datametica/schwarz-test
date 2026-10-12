/* --------------------------------------------------------------------------------
   DDL for table: t_pinfo_header
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PINFO_HEADER CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   pinfo_sid                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key PINFO',
   src_infnr                           VARCHAR(20)      COMMENT 'Nummer des Einkaufsinfosatzes; SAP-Retail: eina.INFNR; SAP-BW: 0info_rec_attr.INFNR',
   sup_sid                             NUMBER(38,0)     COMMENT 'Lieferant; FK auf SUPPLIER; SAP-Retail: eina.LIFNR; SAP-BW: 0info_rec_attr.LIFNR',
   item_sid                            NUMBER(38,0)     COMMENT 'Artikel; FK  auf ITEM; SAP-Retail: eina.MATNR; SAP-BW: 0info_rec_attr.MATNR',
   sap_creation_dt                     DATE             COMMENT 'Erstellungsdatum in SAP-Retail; SAP-Retail: eina.ERDAT; SAP-BW: 0info_rec_attr.erdat; eLWIS: t_s_einfo.rec_ins_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PINFO_HEADER PRIMARY KEY (pinfo_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. PINH; Einkaufsinfosatz - allgemeine Daten; 
             SAP-Retail: eina; 
             SAP BW: 0info_rec_attr;
             ELWIS: t_s_einfo';

