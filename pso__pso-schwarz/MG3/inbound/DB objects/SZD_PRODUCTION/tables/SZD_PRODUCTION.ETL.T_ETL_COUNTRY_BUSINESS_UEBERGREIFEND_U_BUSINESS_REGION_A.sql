create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_COUNTRY_BUSINESS_UEBERGREIFEND_U_BUSINESS_REGION_A (
	LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the location. Key generation based on META table for party key space.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	COUNTRY_GROUP_LOCATION_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the location group',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	COUNTRY_BUSINESS_CD VARCHAR(3) NOT NULL COMMENT 'Natural/Business Key - The code identifying the country according in the SCHWARZ group',
	COUNTRY_BUSINESS_ISO3166_2_CD VARCHAR(3) NOT NULL COMMENT 'Descriptive Attribute - The code identifying the country according to ISO 3166_2',
	COUNTRY_BUSINESS_ISO3166_3_CD VARCHAR(3) NOT NULL COMMENT 'Descriptive Attribute - The code identifying the country according to ISO 3166_3',
	COUNTRY_BUSINESS_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the country is known,',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_COUNTRY_BUSINESS primary key (LOCATION_SID, DWH_VALID_FROM_TMSP)
);