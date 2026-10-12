create or replace TABLE LDL_DATA_PRODUCTION.META.T_BUSINESS_TERM_TO_DATA_ELEMENT (
	BUS_TERM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the business term.',
	DATA_ELEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the data element.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_BUSINESS_TERM_TO_DATA_ELEMENT primary key (DATA_ELEM_SID, BUS_TERM_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity links a business term to its physical representations in the form of data elements.'
;