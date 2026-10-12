create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_MDM_ITEM_SET_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'technical column required by the used ETL framework\n            static 7 for all rows',
	MDM_ITEM_SET_SID NUMBER(38,0) NOT NULL COMMENT 'surrogate key NFPO item_2 set\n            CBX: CNT_ITEM_2,\n            LDL_ITEM_UNIQUE_STYLE.CNT_ITEM.REF_NO,\n            LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS',
	SRC_ITEM_DOC_REF VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'NFPO item_2 instance reference\n            CBX: CNT_ITEM.REF_NO',
	SRC_STYLE_UNIQIDS_CD VARCHAR(2000) NOT NULL COLLATE 'en-ci' COMMENT 'identifier of the style composition in the source system\n            CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS',
	SET_CONTENT_QTY NUMBER(38,0) NOT NULL COMMENT 'total number of units in the set\n            CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS',
	SET_MULTIPACK_FG NUMBER(38,0) NOT NULL COMMENT 'calculated indicator whether as set is composed from more than one style\n            CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS',
	MDM_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'foreign key NFPO item_2 instance\n            CBX: CNT_ITEM.REF_NO',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',
	constraint PK_T_MDM_ITEM_SET primary key (MDM_ITEM_SET_SID)
)COMMENT='NFPO item_2 variant defining sets of styles\n             CBX: LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_STYLE'
;
