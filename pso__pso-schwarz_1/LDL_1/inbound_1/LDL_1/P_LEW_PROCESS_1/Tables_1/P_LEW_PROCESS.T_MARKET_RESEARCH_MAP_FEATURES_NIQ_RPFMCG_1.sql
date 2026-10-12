CREATE TABLE P_LEW_PROCESS.T_MARKET_RESEARCH_MAP_FEATURES_NIQ_RPFMCG_1 (
	COUNTRY_CD VARCHAR(50) NOT NULL,
	DATA_SRC_SEGMENT_NAME VARCHAR(100) NOT NULL,
	FE_FEATURE_NAME VARCHAR(100),
	TECHNICAL_FEATURE_NAME VARCHAR(100) NOT NULL,
	SOURCE_CHAR_DESC VARCHAR(100),
	COLUMN_NAME VARCHAR(100) NOT NULL,
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'    
);
