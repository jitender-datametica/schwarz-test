/* --------------------------------------------------------------------------------
   DDL for table: t_mainitemgroup
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MAINITEMGROUP CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   main_item_grp_sid                   NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key MAINITEMGROUP',
   src_mainitemgrp_id                  NUMBER(38,0)     COMMENT 'WAWI Quellschluessel',
   main_item_grp_name                  VARCHAR(100)     COLLATE 'en-ci' COMMENT 'MainItemGroupName in Stiftungssprache; ',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MAINITEMGROUP PRIMARY KEY (main_item_grp_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. MAIG; 4. Ebene der Artikelhierarchie aus WAWI. Steht oberhalb der SUBITEMGROUP in der WAWI;
             SAP-Retail: -;
             SAP-BW: -;
             ELWIS: -;
             WAWI: t_itm_mainitemgroup';

