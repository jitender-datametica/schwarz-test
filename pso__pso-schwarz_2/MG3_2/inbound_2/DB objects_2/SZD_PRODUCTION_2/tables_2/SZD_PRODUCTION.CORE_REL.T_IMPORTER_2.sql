create or replace TABLE SZD_PRODUCTION.CORE_REL.T_IMPORTER_2 (
	PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the importer.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	IMPORTER_NUMBER VARCHAR(250) NOT NULL COMMENT 'Natural/Business Key - A unique alphanumeric number that identifies the importer.',
	IMPORTER_NAME VARCHAR(100) NOT NULL COMMENT 'This is the importer''s displayable name.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_IMPORTER primary key (PARTY_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Entity - The importer orders goods abroad and must declare them when importing them into his own country. The importer can also make the declarance on the customs authority, if he owns the proper license. - Source - Manual'
;