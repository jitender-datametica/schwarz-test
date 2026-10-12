create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_ITEM_FAMILYGROUP_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT;\n            CBX: Static 7 (Stiftung);\n            ESB: Static 7 (Stiftung);',
	ITEM_FAM_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key ITEM_2 FAMILYGROUP;\n            CBX: Item.ldlArticleGroup.custText1;\n            ESB: cbxItem.itemFamilyGroup.code;\n            ',
	SRC_NODE VARCHAR(20) COMMENT 'Knotennummer aus SAP-Hierarchie;\n            SAP-Retail: wrf_matgrp_struc.node;\n            SAP-BW: z_ds_wrf_matgrp_struc.node;\n            CBX: NULL;\n            ESB: NULL;',
	SRC_FAMILYGRP_CD VARCHAR(20) COMMENT 'WAWI Code;\n            CBX: Item.ldlArticleGroup.custText1;\n            ESB: cbxItem.itemFamilyGroup.code;',
	SRC_FAMILYGRP_ID NUMBER(38,0) COMMENT 'WAWI ID;\n            CBX: NULL;\n            ESB: NULL;',
	ITEM_FAM_GRP_NAME VARCHAR(100) COLLATE 'en-ci' COMMENT 'Familygroupname in Stiftungssprache;\n            SAP-Retail: wrf_matgrp_strct.ltext;\n            SAP-BW: z_ds_wrf_matgrp_strct.ltext;\n            CBX: Item.ldlArticleGroup.custText3;\n            ESB: cbxItem.itemFamilyGroup.name;',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_ITEM_FAMILYGROUP primary key (ITEM_FAM_GRP_SID)
)COMMENT='$Revision: 0000 $. FAMG; 2. Ebene der Artikelhierarchie. Direkt oberhalb des Artikels;'
;
