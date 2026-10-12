create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_DIM_COUNTRY_BUSINESS_GROUP_2 (
	LOCATION_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the location_2 group. Key generation based on META table for party key space.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	COUNTRY_BUSINESS_GROUP_CD VARCHAR(50) NOT NULL COMMENT 'Natural/Business Key -  identifying the country_2 group',
	COUNTRY_BUSINESS_GROUP_NAME VARCHAR(100) NOT NULL COMMENT 'Descriptive Attribute - the name of the country_2 group',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_DIM_COUNTRY_BUSINESS_GROUP primary key (LOCATION_GROUP_SID, DWH_VALID_FROM_TMSP)
);