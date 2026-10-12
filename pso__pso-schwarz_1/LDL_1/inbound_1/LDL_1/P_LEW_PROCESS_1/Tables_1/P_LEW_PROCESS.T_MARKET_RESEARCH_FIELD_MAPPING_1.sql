CREATE TABLE P_LEW_PROCESS.T_MARKET_RESEARCH_FIELD_MAPPING_1 (
	COUNTRY_CD VARCHAR(2) NOT NULL COMMENT 'The code which identifies a country_1 (as defined by a provider of market research data',
	FILE_NAME_PREFIX VARCHAR(20) NOT NULL COMMENT 'File name prefix which differentiates the files among delivery files for the same country_1',
	TOPIC VARCHAR(100) NOT NULL COMMENT 'Data topic (typically: field name)',
	HIERARCHY_LEVEL_NAME VARCHAR(100) NOT NULL COMMENT 'Hierarchy_1 level name',
	TARGET_EXPRESSION VARCHAR(200) NOT NULL COMMENT 'Name space code for source system key',
	REMARK VARCHAR(200) COMMENT 'Remark for this entry',
	ERROR_MSG VARCHAR(200) COMMENT 'Error message on violation of this entry',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_XSIGHT_FIELD_MAPPING PRIMARY KEY (COUNTRY_CD, TOPIC, HIERARCHY_LEVEL_NAME)
)COMMENT='Mapping table for XSIGHT fields'
;