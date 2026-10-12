create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_CONSIGNOR_1 (
	PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the consignor.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	CONSIGNOR_STREAM_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the type of the consignor stream.',
	CONSIGNOR_STREAM_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - The name of the consignor stream',
	IMPORTER_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the importer.',
	IMPORTER_NR VARCHAR(250) NOT NULL COMMENT 'Denormalized Attribute - The business identifier of the importer.',
	IMPORTER_NAME VARCHAR(100) NOT NULL COMMENT 'Denormalized Attribute - The name of the importer.',
	CONSIGNOR_NAME VARCHAR(100) NOT NULL COMMENT 'Natural Key/Business Key - The name of the consignor.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_DIM_CONSIGNOR primary key (PARTY_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Dimension - The consignor wants to import the goods and forwards the relevant data to the broker for the customs declaration or does the customs declaration itself. - Source Manual, Broker Report, CDS Item_1 Report'
;