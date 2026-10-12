create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_DECLARANT_2 (
	PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the declarant.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	DECLARANT_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the type of declarant.',
	DECLARANT_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - The name of the type of the declarant.',
	DECLARANT_NR VARCHAR(250) NOT NULL COMMENT 'Natural Key/Business Key - The business number identifying the declarant.',
	DECLARANT_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the declarant.',
	DECLARANT_AUTH_STATUS_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the authorization status.',
	DECLARANT_AUTH_STATUS_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - The name of the authorization status.',
	DECLARANT_AUTHORIZED_FG BOOLEAN NOT NULL COMMENT 'Denormalized Attribute - A flag indicating whether this declarant is authorized to make declarations.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_DIM_DECLARANT primary key (PARTY_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Dimension - The declarant prepares the customs declaration based on the data he has received from the importer. The declarant will then forward the customs declaration to the appropriate customs authority. A declarant can currently be both a broker and the importer itself. - Source - Manual / Excel-Report from CDS, Broker (per Mail)'
;