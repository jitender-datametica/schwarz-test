/* --------------------------------------------------------------------------------
   DDL for table: t_item_familygroup_descr
   generated from Powerdesigner on Montag, 28. August 2023 13:29:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_familygroup_descr (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='DWH-Mandant; FK auf CLIENT;            CBX: Static 7 (Stiftung);            ESB: Static 7 (Stiftung);'),
item_fam_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Item Familygroup; FK auf ITEM FAMILYGROUP;            SAP-Retail: wrf_matgrp_strct.node;            SAP-BW: z_ds_wrf_matgrp_strct.node;            CBX: Item.ldlArticleGroup.custText1;            ESB: cbxItem.itemFamilyGroup.code;'),
lang_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sprache; FK auf REPORT LANGUAGE;            SAP-Retail: wrf_matgrp_strct.spras;            SAP-BW: z_ds_wrf_matgrp_strct.spras;            CBX: Static @;            ESB: Static @;'),
lang_cd STRING(20)
OPTIONS(description='Sprache - Code;            SAP-Retail: wrf_matgrp_strct.spras;            SAP-BW: z_ds_wrf_matgrp_strct.spras;            CBX: Static @;            ESB: Static @;'),
item_fam_grp_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='Artikelfamilie - Bezeichnung;            SAP-Retail: wrf_matgrp_strct.ltext;            SAP-BW: z_ds_wrf_matgrp_strct.ltext;            ELWIS: t_s_itm_hier_node_descr.descr_short;            CBX: Item.ldlArticleGroup.custText3;            ESB: cbxItem.itemFamilyGroup.name;'),
item_fam_grp_descr_long STRING(100) COLLATE 'und:ci'
OPTIONS(description='Artikelfamilie - Bezeichnung - lang;            SAP-Retail: wrf_matgrp_strct.ltextlg;            SAP-BW: z_ds_wrf_matgrp_strct.ltextlg;            ELWIS: t_s_itm_hier_node_descr.descr_long;            CBX: Item.ldlArticleGroup.custText3;            ESB: cbxItem.itemFamilyGroup.name;'),
item_fam_grp_descr_caps STRING(100) COLLATE 'und:ci'
OPTIONS(description='Artikelfamilie - Bezeichnung - Gro?buchstaben;            SAP-Retail: wrf_matgrp_strct.ltextg;            SAP-BW: z_ds_wrf_matgrp_strct.ltextg;            ELWIS: t_s_itm_hier_node_descr.descr_caps;            CBX: Item.ldlArticleGroup.custText3;            ESB: upper-case(cbxItem.itemFamilyGroup.name);'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_fam_grp_sid, lang_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. IFAD; Sprachabhaengige Bezeichnung der Item Familygroup;             SAP-Retail: wrf_matgrp_strct;             SAP-BW: z_ds_wrf_matgrp_strct; Filter auf HIER_ID = "L1"              ELWIS: t_s_itm_hier_node_descr;             CBX: Item.ldlArticleGroup;             ESB: cbxItem.itemFamilyGroup;');