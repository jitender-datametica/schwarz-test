/* --------------------------------------------------------------------------------
   DDL for table: t_purchase_group
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PURCHASE_GROUP CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   pur_grp_sid                         NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key PURCHASE GROUP',
   src_ekgrp                           VARCHAR(20)      COMMENT 'Quellsystemschluessel SAP-Retail: t024.EKGRP',
   pur_grp_name                        VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Einkaufergruppe (in Stiftungssprache); SAP-Retail: t024.EKNAM',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PURCHASE_GROUP PRIMARY KEY (pur_grp_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. PGRP; Einkaufsgruppen; 
             SAP-Retail: T024;
             SAP-BW: t_bw_z_ds_t024;
             ELWIS: t_r_pur_grp';

