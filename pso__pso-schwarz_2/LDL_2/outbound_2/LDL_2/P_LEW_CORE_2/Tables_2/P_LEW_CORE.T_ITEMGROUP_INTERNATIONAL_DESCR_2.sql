/* --------------------------------------------------------------------------------
   DDL for table: t_itemgroup_international_descr_2
   generated from Powerdesigner on Montag, 28. August 2023 13:32:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_itemgroup_international_descr_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_grp_int_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ItemGroup_2 International; FK auf ITEMGROUP_2 INTERNATIONAL; SAP-Retail: wrf_matgrp_strct.node; SAP-BW: z_ds_wrf_matgrp_strct.node'),
lang_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sprache; FK auf REPORT LANGUAGE; SAP-Retail: wrf_matgrp_strct.spras; SAP-BW: z_ds_wrf_matgrp_strct.spras'),
lang_cd STRING(20)
OPTIONS(description='Sprache - Code; SAP-Retail: wrf_matgrp_strct.spras; SAP-BW: z_ds_wrf_matgrp_strct.spras'),
item_grp_int_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='ItemGroup_2 International - Bezeichnung; SAP-Retail: wrf_matgrp_strct.ltext; SAP-BW: z_ds_wrf_matgrp_strct.ltext; ELWIS: t_s_itm_hier_node_descr.descr_short'),
item_grp_int_descr_long STRING(100) COLLATE 'und:ci'
OPTIONS(description='ItemGroup_2 International - Bezeichnung - lang; SAP-Retail: wrf_matgrp_strct.ltextlg; SAP-BW: z_ds_wrf_matgrp_strct.ltextlg; ELWIS: t_s_itm_hier_node_descr.descr_long'),
item_grp_int_descr_caps STRING(100) COLLATE 'und:ci'
OPTIONS(description='ItemGroup_2 International - Bezeichnung - Grossbuchstaben; SAP-Retail: wrf_matgrp_strct.ltextg; SAP-BW: z_ds_wrf_matgrp_strct.ltextg; ELWIS: t_s_itm_hier_node_descr.descr_caps'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_grp_int_sid, lang_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. IFAD; Sprachabhaengige Bezeichnung der ItemGroup_2 International;             SAP-Retail: wrf_matgrp_strct_2;             SAP-BW: z_ds_wrf_matgrp_strct;             Filter auf HIER_ID = "L1";             ELWIS: t_s_itm_hier_node_descr;             WAWI: t_itm_itemgroup_int_2');