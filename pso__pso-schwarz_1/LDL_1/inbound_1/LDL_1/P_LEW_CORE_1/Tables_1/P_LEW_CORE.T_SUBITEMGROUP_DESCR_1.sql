/* --------------------------------------------------------------------------------
   DDL for table: t_subitemgroup_descr_1
   generated from Powerdesigner on Montag, 28. August 2023 13:30:42
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SUBITEMGROUP_DESCR_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   sub_item_grp_sid                    NUMBER(38,0)     NOT NULL COMMENT 'SubItemGroup; FK auf SUBITEMGROUP; SAP-Retail: wrf_matgrp_strct.node; SAP-BW: z_ds_wrf_matgrp_strct.node',
   lang_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Sprache; FK auf REPORT LANGUAGE; SAP-Retail: wrf_matgrp_strct.spras; SAP-BW: z_ds_wrf_matgrp_strct.spras',
   lang_cd                             VARCHAR(20)      COMMENT 'Sprache - Code; SAP-Retail: wrf_matgrp_strct.spras; SAP-BW: z_ds_wrf_matgrp_strct.spras',
   sub_item_grp_descr                  VARCHAR(100)     COLLATE 'en-ci' COMMENT 'SubItemGroup - Bezeichnung; SAP-Retail: wrf_matgrp_strct.ltext; SAP-BW: z_ds_wrf_matgrp_strct.ltext; ELWIS: t_s_itm_hier_node_descr.descr_short',
   sub_item_grp_descr_long             VARCHAR(100)     COLLATE 'en-ci' COMMENT 'SubItemGroup - Bezeichnung - lang; SAP-Retail: wrf_matgrp_strct.ltextlg; SAP-BW: z_ds_wrf_matgrp_strct.ltextlg; ELWIS: t_s_itm_hier_node_descr.descr_long',
   sub_item_grp_descr_caps             VARCHAR(100)     COLLATE 'en-ci' COMMENT 'SubItemGroup - Bezeichnung - Grosbuchstaben; SAP-Retail: wrf_matgrp_strct.ltextg; SAP-BW: z_ds_wrf_matgrp_strct.ltextg; ELWIS: t_s_itm_hier_node_descr.descr_caps',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_SUBITEMGROUP_DESCR PRIMARY KEY (sub_item_grp_sid, lang_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. SUID; Sprachabhaengige Bezeichnung der SubItemGroup;
             SAP-Retail: wrf_matgrp_strct_1;
             SAP-BW: z_ds_wrf_matgrp_strct;
             ELWIS: t_s_itm_hier_node_descr;
             WAWI: t_itm_subitemgroup_desc_1';
