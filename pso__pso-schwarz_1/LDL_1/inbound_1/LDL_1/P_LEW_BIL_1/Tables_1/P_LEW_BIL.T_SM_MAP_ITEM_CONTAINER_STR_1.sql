create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_BIL.T_SM_MAP_ITEM_CONTAINER_STR_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Landeskennzeichen',
	ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'Artikelnummer',
	LOC_SID_WH NUMBER(38,0) COMMENT 'Surrogate Key LOCATION_1 (eindeutig ueber alle Laender/Mandanten hinweg)',
	WH_ID NUMBER(38,0) COMMENT 'WH ID from source (WAWI)',
	CONTAINER_ID NUMBER(38,0) COMMENT 'Surrogate Key container',
	MOVE_TO_STORE_ID NUMBER(38,0) NOT NULL COMMENT 'Store-Nr',
	ASPECT_ID NUMBER(38,0) COMMENT 'only 1= BGES',
	DAT_REC_START DATE COMMENT 'Gültigkeitsdatum von',
	DAT_REC_END DATE COMMENT 'Gültigkeitsdatum bis'
)COMMENT='Base Relation-Table for item_1 assignment to container on store level'
;
