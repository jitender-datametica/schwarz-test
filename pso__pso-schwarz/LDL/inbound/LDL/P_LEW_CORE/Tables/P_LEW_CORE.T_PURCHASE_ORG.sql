/* --------------------------------------------------------------------------------
   DDL for table: t_purchase_org
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PURCHASE_ORG CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   pur_org_sid                         NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key PURCHASE ORGANIZATION',
   src_ekorg                           VARCHAR(20)      COMMENT 'Quellsystemschluessel SAP-Retail: t024E.EKORG',
   pur_org_name                        VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Einkaufsorganisation (in Stiftungssprache); SAP-Retail: t024E.EKOTX',
   comp_sid                            NUMBER(38,0)     COMMENT 'Buchungskreis; FK auf COMPANY; SAP-Retail: t024E.BUKRS',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PURCHASE_ORG PRIMARY KEY (pur_org_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. PORG; Einkaufsorganisationen; 
             SAP-Retail-Tabelle: t024E;
             SAP-BW: t_bw_0purch_org_text;
             ELWIS: t_s_pur_org_descr';

