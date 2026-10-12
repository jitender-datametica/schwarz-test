/* --------------------------------------------------------------------------------
   DDL for table: t_subitemgroup_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SUBITEMGROUP_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   sub_item_grp_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SUBITEMGROUP',
   src_node                            VARCHAR(20)      COMMENT 'Knotennummer aus SAP-Hierarchie; SAP-Retail: wrf_matgrp_struc.node; SAP-BW: z_ds_wrf_matgrp_struc.node',
   src_subitemgrp_cd                   VARCHAR(20)      COMMENT 'WAWI CD',
   src_subitemgrp_id                   NUMBER(38,0)     COMMENT 'WAWI ID',
   sub_item_grp_name                   VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Subitemgroupname in Stiftungssprache; SAP-Retail: wrf_matgrp_strct.ltext; SAP-BW: z_ds_wrf_matgrp_strct.ltext',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SUBITEMGROUP PRIMARY KEY (sub_item_grp_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. SUIG; 3. level item_1 hierarchy_1 - right above item_1 famgrp;
             SAP-Retail: wrf_matgrp_struc;
             SAP-BW: z_ds_wrf_matgrp_struc, Filter: HIER_ID="L1" & TREE_LEVEL="03";
             ELWIS: t_s_itm_hier_node / t_l_itm_hier_struct;
             WAWI: t_itm_subitemgroup_1';

