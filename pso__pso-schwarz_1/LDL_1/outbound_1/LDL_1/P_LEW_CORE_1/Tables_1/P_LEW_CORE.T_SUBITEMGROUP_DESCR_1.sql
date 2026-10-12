/* --------------------------------------------------------------------------------
   DDL for table: t_subitemgroup_descr_1
   generated from Powerdesigner on Montag, 28. August 2023 13:30:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_subitemgroup_descr_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
sub_item_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SubItemGroup; FK auf SUBITEMGROUP; SAP-Retail: wrf_matgrp_strct.node; SAP-BW: z_ds_wrf_matgrp_strct.node'),
lang_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sprache; FK auf REPORT LANGUAGE; SAP-Retail: wrf_matgrp_strct.spras; SAP-BW: z_ds_wrf_matgrp_strct.spras'),
lang_cd STRING(20)
OPTIONS(description='Sprache - Code; SAP-Retail: wrf_matgrp_strct.spras; SAP-BW: z_ds_wrf_matgrp_strct.spras'),
sub_item_grp_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='SubItemGroup - Bezeichnung; SAP-Retail: wrf_matgrp_strct.ltext; SAP-BW: z_ds_wrf_matgrp_strct.ltext; ELWIS: t_s_itm_hier_node_descr.descr_short'),
sub_item_grp_descr_long STRING(100) COLLATE 'und:ci'
OPTIONS(description='SubItemGroup - Bezeichnung - lang; SAP-Retail: wrf_matgrp_strct.ltextlg; SAP-BW: z_ds_wrf_matgrp_strct.ltextlg; ELWIS: t_s_itm_hier_node_descr.descr_long'),
sub_item_grp_descr_caps STRING(100) COLLATE 'und:ci'
OPTIONS(description='SubItemGroup - Bezeichnung - Grosbuchstaben; SAP-Retail: wrf_matgrp_strct.ltextg; SAP-BW: z_ds_wrf_matgrp_strct.ltextg; ELWIS: t_s_itm_hier_node_descr.descr_caps'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (sub_item_grp_sid, lang_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. SUID; Sprachabhaengige Bezeichnung der SubItemGroup;             SAP-Retail: wrf_matgrp_strct_1;             SAP-BW: z_ds_wrf_matgrp_strct;             ELWIS: t_s_itm_hier_node_descr;             WAWI: t_itm_subitemgroup_desc_1');