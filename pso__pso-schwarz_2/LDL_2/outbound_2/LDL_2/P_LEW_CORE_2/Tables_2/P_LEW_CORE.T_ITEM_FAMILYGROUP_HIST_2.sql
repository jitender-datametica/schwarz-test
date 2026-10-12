/* --------------------------------------------------------------------------------
   DDL for table: t_item_familygroup_hist_2
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:39:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_familygroup_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='DWH-Mandant_2; FK auf CLIENT;            CBX: Static 7 (Stiftung);            ESB: Static 7 (Stiftung);'),
item_fam_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM_2 FAMILYGROUP;            CBX: Item.ldlArticleGroup.custText1;            ESB: cbxItem.itemFamilyGroup.code;'),
sub_item_grp_sid BIGNUMERIC(38,0)
OPTIONS(description='Subitemgroup; FK auf SUBITEMGROUP;            SAP-Retail: wrf_matgrp_struc.parent;            SAP-BW: z_ds_wrf_matgrp_struc.parent;            CBX: NULL;            ESB: NULL;'),
sub_item_grp_cd STRING(20)
OPTIONS(description='Knotennummer der Suitemgroup aus SAP-Hierachie (= t_subitemgroup.src_node);            SAP-Retail: wrf_matgrp_struc.parent;            SAP-BW: z_ds_wrf_matgrp_struc.parent;            CBX: Item.ldlArticleGroup.custText5;            ESB: cbxItem.itemFamilyGroup.groupCode;'),
mdm_assortment_area_id BIGNUMERIC(38,0)
OPTIONS(description='code of the NFPO assortment area            CBX:  CNT_CODELIST.CUSTOM_FIELD_TEXT5  (code list\'REPORT_AF_PILLAR_PRODUCTCATEGORY\')'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Item_2 Familygroup ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_fam_grp_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. FAMGH; 2. Ebene der Artikelhierarchie. Direkt oberhalb des Artikels;');