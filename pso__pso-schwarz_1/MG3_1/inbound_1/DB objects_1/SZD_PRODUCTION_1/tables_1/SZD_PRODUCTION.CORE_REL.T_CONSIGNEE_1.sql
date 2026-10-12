create or replace TABLE SZD_PRODUCTION.CORE_REL.T_CONSIGNEE_1 (
	PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the consignee party.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	COUNTRY_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the political country_1 of the consignee.',
	CONSIGNEE_NAME VARCHAR(100) NOT NULL COMMENT 'Natural Key/Business Key - The name of the consignee.',
	CONSIGNEE_ADDITIONAL_NAME VARCHAR(100) COMMENT 'A additional or alternative name of the consignee.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_CONSIGNEE primary key (PARTY_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Entity - The consignee receives the goods ordered by a consignor. - Source - BEI/WWT Report'
;