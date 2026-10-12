create or replace TABLE SZD_PRODUCTION.CORE_REL.T_BROKER_1 (
	PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the broker.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	BROKER_NUMBER VARCHAR(250) NOT NULL COMMENT 'Natural/Business Key - A unique alphanumeric number that identifies the broker.',
	BROKER_NAME VARCHAR(100) NOT NULL COMMENT 'This is the broker''s displayable name.',
	BROKER_POSTCODE VARCHAR(50) COMMENT 'The postcode of the broker as currently held in CHIEF/CDS Standing Data',
	BROKER_AUTHORIZED_FG BOOLEAN NOT NULL COMMENT 'A flag indicating this broker is authorized to make declarations to the customs authority.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_BROKER primary key (PARTY_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Entity - The broker prepares the customs declaration on behalf of the importer and submits it to the respective customs authority. - Source - Manual / Excel-Report from CDS, Broker (per Mail)'
;