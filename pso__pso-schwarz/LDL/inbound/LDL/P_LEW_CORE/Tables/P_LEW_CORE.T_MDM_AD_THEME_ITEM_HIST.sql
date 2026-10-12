create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_MDM_AD_THEME_ITEM_HIST (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'technical column required by the used ETL framework\n            static 7 for all rows',
	MDM_AD_THEME_SID NUMBER(38,0) NOT NULL COMMENT 'foreign key NFPO advertising theme\n            CBX: CNT_ITEM.LDL_THEME_REF',
	MDM_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'foreign key NFPO item instance\n            CBX: CNT_ITEM.REF_NO',
	DELETED_FG NUMBER(38,0) NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
	DWH_VALID_FROM DATE NOT NULL COMMENT 'begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
	DWH_VALID_TO DATE NOT NULL COMMENT 'end of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',
	constraint PK_T_MDM_AD_THEME_ITEM_HIST primary key (MDM_ITEM_SID, MDM_AD_THEME_SID, DWH_VALID_FROM)
)COMMENT='relation between items and advertising themes\n             CBX: CNT_ITEM'
;
