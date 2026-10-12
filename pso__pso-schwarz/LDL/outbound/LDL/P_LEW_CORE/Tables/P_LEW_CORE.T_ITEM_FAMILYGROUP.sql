/* --------------------------------------------------------------------------------
   DDL for table: t_item_familygroup
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_familygroup (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='DWH-Mandant; FK auf CLIENT;            CBX: Static 7 (Stiftung);            ESB: Static 7 (Stiftung);'),
item_fam_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM FAMILYGROUP;            CBX: Item.ldlArticleGroup.custText1;            ESB: cbxItem.itemFamilyGroup.code;            '),
src_node STRING(20)
OPTIONS(description='Knotennummer aus SAP-Hierarchie;            SAP-Retail: wrf_matgrp_struc.node;            SAP-BW: z_ds_wrf_matgrp_struc.node;            CBX: NULL;            ESB: NULL;'),
src_familygrp_cd STRING(20)
OPTIONS(description='WAWI Code;            CBX: Item.ldlArticleGroup.custText1;            ESB: cbxItem.itemFamilyGroup.code;'),
src_familygrp_id BIGNUMERIC(38,0) OPTIONS(description='WAWI ID;            CBX: NULL;            ESB: NULL;'),
item_fam_grp_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Familygroupname in Stiftungssprache;            SAP-Retail: wrf_matgrp_strct.ltext;            SAP-BW: z_ds_wrf_matgrp_strct.ltext;            CBX: Item.ldlArticleGroup.custText3;            ESB: cbxItem.itemFamilyGroup.name;'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (item_fam_grp_sid) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. FAMG; 2. Ebene der Artikelhierarchie. Direkt oberhalb des Artikels;');