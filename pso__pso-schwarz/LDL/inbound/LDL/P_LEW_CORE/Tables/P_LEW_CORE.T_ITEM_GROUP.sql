/* --------------------------------------------------------------------------------
   DDL for table: t_item_group
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_GROUP (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   item_grp_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM GROUP',
   src_matkl                           VARCHAR(20)      COMMENT 'Warengruppen-Code (SAP-Retail); SAP-Retail: t023.matkl; SAP-BW: t_bw_0matl_group_text.matkl',
   src_wawi_cd                         VARCHAR(20)      COMMENT 'Warengruppen-Code (WAWI)',
   item_grp_name                       VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bezeichnung in Stiftungssprache; SAP-Retail: t023t.wgbez; SAP-BW: t_bw_0matl_group_text.wgbez',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_ITEM_GROUP PRIMARY KEY (item_grp_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IGRP; Warengruppen; 
             SAP-Retail: T023; 
             SAP-BW: t_bw_0matl_group_text;
             WAWI-Tabelle
             Code wahrscheinlich 1:1 Subitemgroup';

