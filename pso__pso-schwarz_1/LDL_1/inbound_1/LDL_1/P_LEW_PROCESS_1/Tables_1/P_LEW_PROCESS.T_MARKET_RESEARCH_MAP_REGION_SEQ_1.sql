CREATE TABLE P_LEW_PROCESS.T_MARKET_RESEARCH_MAP_REGION_SEQ_1 (
	COUNTRY_CD VARCHAR(10) NOT NULL,
	GEOGRAPHY_NAME VARCHAR(100),
	GEOGRAPHY_VALUE VARCHAR(100),
	DISPLAY_SEQ VARCHAR(100),
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
);
