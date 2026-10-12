create or replace TABLE LDL_DATA_PRODUCTION.META.T_BUSINESS_TERM_SYNONYM_2 (
	BUS_TERM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the business term.',
	ALT_BUS_TERM_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the term is also known',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_BUSINESS_TERM_SYNONYM primary key (BUS_TERM_SID, ALT_BUS_TERM_NAME, DWH_VALID_FROM_TMSP)
)COMMENT='A business term may be known under several names. This entity tracks the synonyms of a business term.'
;