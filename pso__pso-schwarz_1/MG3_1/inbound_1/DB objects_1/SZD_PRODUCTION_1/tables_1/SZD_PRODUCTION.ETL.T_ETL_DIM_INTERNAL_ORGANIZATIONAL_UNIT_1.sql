create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_DIM_INTERNAL_ORGANIZATIONAL_UNIT_1 (
	PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	BUSINESS_UNIT_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party. It defines the business unit_1 of the organizational unit. Key generation based on META table for party key space.',
	INT_ORG_UNIT_NR NUMBER(38,0) NOT NULL COMMENT 'The identifier of an  organizational unit_1',
	INT_ORG_UNIT_NAME VARCHAR(100) NOT NULL COMMENT 'The textual name of an organization unit_1',
	SYNONYM_INT_ORG_UNIT_NAME VARCHAR(100) COMMENT 'Descriptive Attribute - The sysonym name of the organizational unit_1 specified for IT4You, could be slightly different, denpendent on business requirement',
	SOURCE_INT_ORG_UNIT_HIERARCHY_LVL_NR NUMBER(38,0) COMMENT 'The hierarchial level number of the organizational unit_1 in source system.',
	INT_ORG_UNIT_HIERARCHY_LVL_NR NUMBER(38,0) NOT NULL COMMENT 'The hierarchial level number of the organizational unit_1 build in the data warehouse. It corresponds not directly to source system department level (conversion is dwh level - 1 = source system level)',
	SOURCE_SYS_NR VARCHAR(100) NOT NULL COMMENT 'Source system payload attribute - Technical Surrogate Key (surves as Natural Key) - additional technical system id for identification of tickets.',
	SOURCE_UPDATED_ON_TMSP TIMESTAMP_TZ(9) COMMENT 'Source system payload attribute - The point in time when this record was last modified in the source system. (In case the record has not been modified since its creation, source_updated_on is identical to creation timestamp)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_DIM_INTERNAL_ORGANIZATIONAL_UNIT primary key (PARTY_SID, DWH_VALID_FROM_TMSP)
);