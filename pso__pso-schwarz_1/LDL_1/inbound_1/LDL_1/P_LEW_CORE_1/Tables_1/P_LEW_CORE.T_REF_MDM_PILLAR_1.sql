create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_MDM_PILLAR_1 (
	MDM_PILLAR_SID NUMBER(38,0) NOT NULL COMMENT 'surrogate key, identifier of the pillar in NFPO source system, alternative item_1 grouping for non food items in addition to the standard grouping based on item_1 families\n            CBX: CNT_ITEM.LDL_PILLAR',
	MDM_PILLAR_NAME VARCHAR(100) NOT NULL COMMENT 'name of the pillar in NFPO source system, alternative item_1 grouping for non food items in addition to the standard grouping based on item_1 families\n            CBX: CNT_ITEM.LDL_PILLAR',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',
	constraint PK_T_REF_MDM_PILLAR primary key (MDM_PILLAR_SID)
)COMMENT='NFPO alternative item_1 grouping\n             CBX: CNT_ITEM.LDL_PILLAR'
;
