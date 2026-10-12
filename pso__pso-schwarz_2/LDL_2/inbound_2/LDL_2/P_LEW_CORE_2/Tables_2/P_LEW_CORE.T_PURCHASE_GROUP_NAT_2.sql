/* --------------------------------------------------------------------------------
   DDL for table: t_purchase_group_nat_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PURCHASE_GROUP_NAT_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   pur_grp_nat_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key PURCHASE GROUP NAT',
   src_ekgrp                           VARCHAR(20)      COMMENT 'Quellsystemschluessel SAP-Retail: zmmx008_ekgrp_sh.ekgrp; SAP-BW: z_ds_ekgrp.ekgrp',
   pur_grp_nat_name                    VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Einkaufergruppe (in Stiftungssprache); SAP-Retail: zmmx008_ekgrp_sh.eknam; SAP-BW: z_ds_ekgrp.txtmd',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PURCHASE_GROUP_NAT PRIMARY KEY (pur_grp_nat_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Einkaeufergruppen national; 
             SAP-Retail: ZMMX008_EKGRP_SH;
             SAP-BW: z_ds_ekgrp;
             ELWIS: -';

