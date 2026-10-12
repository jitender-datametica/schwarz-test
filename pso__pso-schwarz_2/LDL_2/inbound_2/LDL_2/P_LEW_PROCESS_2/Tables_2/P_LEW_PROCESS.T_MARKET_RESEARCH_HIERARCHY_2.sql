CREATE TABLE P_LEW_PROCESS.T_MARKET_RESEARCH_HIERARCHY_2 (
	COUNTRY_CD VARCHAR(2) NOT NULL COMMENT 'The code which identifies a country_2 (as defined by a provider of market research data',
	FILE_NAME_PREFIX VARCHAR(20) NOT NULL COMMENT 'File name prefix which differentiates the files among delivery files for the same country_2',
	HIERARCHY_NUMBER NUMBER(38,0) NOT NULL COMMENT 'Hierarchy_2 number',
	HIERARCHY_LEVEL NUMBER(38,0) NOT NULL COMMENT 'Hierarchy_2 level',
	DIMENSION VARCHAR(100) NOT NULL COMMENT 'Dimension',
	HIERARCHY_LEVEL_NAME VARCHAR(100) NOT NULL COMMENT 'Hierarchy_2 level name',
	COLUMN_NAME VARCHAR(100) NOT NULL COMMENT 'Column name',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_XSIGHT_FIELD_MAPPING PRIMARY KEY (COUNTRY_CD, DIMENSION, HIERARCHY_NUMBER, HIERARCHY_LEVEL)
)COMMENT='Mapping table for XSIGHT fields'
;