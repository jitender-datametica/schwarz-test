/* --------------------------------------------------------------------------------
   DDL for table: t_itemgroup_international
   generated from Powerdesigner on Montag, 28. August 2023 13:31:32
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEMGROUP_INTERNATIONAL (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   item_grp_int_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEMGROUP INTERNATIONAL',
   src_node                            VARCHAR(20)      COMMENT 'Knotennummer aus SAP-Hierarchie; SAP-Retail: wrf_matgrp_struc.node; SAP-BW: z_ds_wrf_matgrp_struc.node',
   src_itemgrp_int_cd                  VARCHAR(20)      COMMENT 'WAWI Code',
   src_itemgrp_int_id                  NUMBER(38,0)     COMMENT 'WAWI ID',
   item_grp_int_name                   VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Name der Subitemgroup Intenational in Stiftungssprache; SAP-Retail: wrf_matgrp_strct.ltext; SAP-BW: z_ds_wrf_matgrp_strct.ltext',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEMGROUP_INTERNATIONAL PRIMARY KEY (item_grp_int_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IGRI; 4. level item hierarchy - right above subitemgroup;
             SAP-Retail: wrf_matgrp_struc;
             SAP-BW: z_ds_wrf_matgrp_struc, Filter: HIER_ID="L1" & TREE_LEVEL="02"
             ELWIS: t_s_itm_hier_node / t_l_itm_hier_struct;
             WAWI: t_itm_itemgroup_int';
