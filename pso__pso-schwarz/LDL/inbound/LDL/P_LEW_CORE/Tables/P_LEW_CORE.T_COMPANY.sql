/* --------------------------------------------------------------------------------
   DDL for table: t_company
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_COMPANY CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   comp_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key COMPANY',
   src_bukrs                           VARCHAR(20)      COMMENT 'Quellsystemschluessel SAP-Retail: t001.bukrs; SAP-BW: t_bw_0comp_code_attr.bukrs',
   addr_sid                            NUMBER(38,0)     COMMENT 'Adresse; FK auf ADDRESS; SAP-Retail: t001.adrnr; SAP-BW: t_bw_0comp_code_attr.adrnr',
   comp_name                           VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Name der Firma; SAP-Retail: t001.butxt; SAP-BW: t_bw_0comp_code_attr.butxt',
   city                                VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Ort; SAP-Retail: t001.ort01; SAP-BW: t_bw_0comp_code_attr.ort01',
   account_plan_cd                     VARCHAR(20)      COMMENT 'Kontenplan; SAP-Retail: T001.ktopl; SAP-BW: t_bw_0comp_code_attr.ktopl',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_COMPANY PRIMARY KEY (comp_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. CMPY; Buchungskreise; 
             SAP-Retail: T001; 
             SAP-BW: t_bw_0comp_code_attr;
             ELWIS: t_h_company';

