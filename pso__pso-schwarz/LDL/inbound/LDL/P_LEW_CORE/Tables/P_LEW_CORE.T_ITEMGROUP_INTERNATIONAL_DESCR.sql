/* --------------------------------------------------------------------------------
   DDL for table: t_itemgroup_international_descr
   generated from Powerdesigner on Montag, 28. August 2023 13:32:11
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEMGROUP_INTERNATIONAL_DESCR CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   item_grp_int_sid                    NUMBER(38,0)     NOT NULL COMMENT 'ItemGroup International; FK auf ITEMGROUP INTERNATIONAL; SAP-Retail: wrf_matgrp_strct.node; SAP-BW: z_ds_wrf_matgrp_strct.node',
   lang_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Sprache; FK auf REPORT LANGUAGE; SAP-Retail: wrf_matgrp_strct.spras; SAP-BW: z_ds_wrf_matgrp_strct.spras',
   lang_cd                             VARCHAR(20)      COMMENT 'Sprache - Code; SAP-Retail: wrf_matgrp_strct.spras; SAP-BW: z_ds_wrf_matgrp_strct.spras',
   item_grp_int_descr                  VARCHAR(100)     COLLATE 'en-ci' COMMENT 'ItemGroup International - Bezeichnung; SAP-Retail: wrf_matgrp_strct.ltext; SAP-BW: z_ds_wrf_matgrp_strct.ltext; ELWIS: t_s_itm_hier_node_descr.descr_short',
   item_grp_int_descr_long             VARCHAR(100)     COLLATE 'en-ci' COMMENT 'ItemGroup International - Bezeichnung - lang; SAP-Retail: wrf_matgrp_strct.ltextlg; SAP-BW: z_ds_wrf_matgrp_strct.ltextlg; ELWIS: t_s_itm_hier_node_descr.descr_long',
   item_grp_int_descr_caps             VARCHAR(100)     COLLATE 'en-ci' COMMENT 'ItemGroup International - Bezeichnung - Grossbuchstaben; SAP-Retail: wrf_matgrp_strct.ltextg; SAP-BW: z_ds_wrf_matgrp_strct.ltextg; ELWIS: t_s_itm_hier_node_descr.descr_caps',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEMGROUP_INTERNATIONAL_DESCR PRIMARY KEY (item_grp_int_sid, lang_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IFAD; Sprachabhaengige Bezeichnung der ItemGroup International;
             SAP-Retail: wrf_matgrp_strct;
             SAP-BW: z_ds_wrf_matgrp_strct;
             Filter auf HIER_ID = "L1";
             ELWIS: t_s_itm_hier_node_descr;
             WAWI: t_itm_itemgroup_int';
