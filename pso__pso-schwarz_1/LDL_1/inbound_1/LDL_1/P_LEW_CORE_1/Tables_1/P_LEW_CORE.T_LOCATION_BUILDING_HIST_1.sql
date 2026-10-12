create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_LOCATION_BUILDING_HIST_1 cluster by (CLIENT_ID)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice',
	LOC_SID NUMBER(38,0) NOT NULL COMMENT 'Store orWarehouse (organizational unit_1) ',
	BUILDING_SID NUMBER(38,0) NOT NULL COMMENT 'related physical building',
	DELETED_FG NUMBER(38,0) NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
	DWH_VALID_FROM DATE NOT NULL COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
	DWH_VALID_TO DATE NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_LOCATION_BUILDING_HIST primary key (LOC_SID, DWH_VALID_FROM)
)COMMENT='$Revision: 0000 $. Relationship between buildings and organisational locations (Stores and WHs)'
;
