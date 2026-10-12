create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_USER_GROUP_UEBERGREIFEND_SYS_USER_GROUP_B (
	PARTY_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party group as user group. Key generation based on META table for party key space.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	ORG_UNIT_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party org unit. Key generation based on META table for party key space.',
	BUSINESS_UNIT_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party business unit. Key generation based on META table for party key space.',
	COUNTRY_BUSINESS_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the location as a business country .Key generation based on META table for party key space.',
	DIVISION_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division .Key generation based on META table for party key space.',
	USER_GROUP_NR NUMBER(38,0) NOT NULL COMMENT 'Natural/Business Key - id of user group',
	USER_GROUP_NAME VARCHAR(100) NOT NULL COMMENT 'The group name by which the user group is identified on the system.',
	USER_GROUP_ACTIVE_FG BOOLEAN NOT NULL COMMENT 'Flag for user validity. TRUE - User group is valid in IT4YOU. FALSE - User group is not valid anymore in IT4you.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_USER_GROUP primary key (PARTY_GROUP_SID, DWH_VALID_FROM_TMSP)
);