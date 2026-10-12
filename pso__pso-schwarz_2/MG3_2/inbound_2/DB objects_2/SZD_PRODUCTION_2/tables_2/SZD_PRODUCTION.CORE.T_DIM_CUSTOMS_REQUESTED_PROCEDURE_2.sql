create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_CUSTOMS_REQUESTED_PROCEDURE_2 (
	REQUESTED_PROCEDURE_CD VARCHAR(50) NOT NULL COMMENT 'Natural Key/Business Key - The unique code of the type of requested procedure.',
	REQUESTED_PROCEDURE_DESCR VARCHAR(250) NOT NULL COMMENT 'The name of the type of the requested procedure.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_DIM_CUSTOMS_REQUESTED_PROCEDURE primary key (REQUESTED_PROCEDURE_CD)
)COMMENT='Minor Dimension - Defines the requested procedure codes (the first four characters in a customs procedure code) and ther meaning. - Source - Manual'
;