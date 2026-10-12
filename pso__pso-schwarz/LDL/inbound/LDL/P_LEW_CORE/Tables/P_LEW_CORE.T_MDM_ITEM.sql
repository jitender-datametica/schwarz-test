create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_MDM_ITEM (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'technical column required by the used ETL framework\n            static 7 for all rows',
	MDM_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'surrogate key NFPO item instance\n            CBX: CNT_ITEM.REF_NO',
	SRC_ITEM_DOC_REF VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'NFPO item instance reference\n            CBX: CNT_ITEM.REF_NO',
	MDM_ITEM_NAME VARCHAR(100) NOT NULL COMMENT 'NFPO item name\n            CBX: CNT_ITEM.ITEM_DESC, SHORT_DESC',
	ITEM_IAN NUMBER(38,0) NOT NULL COMMENT 'Lidl International Item Number (not necessarily unique in this table - numbers can be reused if an item is cancelled, or multiple item instances will be created for catalog items);\n            CBX: CNT_ITEM.ITEM_NO',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',
	RANGE_PLAN_CD VARCHAR(20) COLLATE 'en-ci' COMMENT 'Range selection number (Ausmusterungsnummer), initially assigned to the item instance\n            CBX: CNT_ITEM.LDL_LOT_NO',
	ITEM_SELECTION_NR VARCHAR(20) COLLATE 'en-ci' COMMENT 'NFPO source system internal identifier of an article\n            CBX: CNT_ITEM.LDL_SELECTION_NO',
	STEP_ITEM_NR VARCHAR(20) COLLATE 'en-ci' COMMENT 'STEP internal identifier of an article, only available if an item can be ordered by Kaufland countries\n            STEP:STEP_ID\n            ',
	constraint PK_T_MDM_ITEM primary key (MDM_ITEM_SID)
)COMMENT='instances of NFPO items in the quarterly item planning and ordering process. For catalog items there might be several instances in this table, all sharing the same international article number\n             CBX: CNT_ITEM'
;
