create or replace TABLE LDL_DATA_PRODUCTION.META.T_QUERY_ERROR_CODE_1 (
	QUERY_ERROR_CD VARCHAR(20) NOT NULL COMMENT 'The error code, as defined by the database engine.',
	QUERY_ERROR_DESCR VARCHAR(250) NOT NULL COMMENT 'The description for the error.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_QUERY_ERROR_CODE primary key (QUERY_ERROR_CD)
)COMMENT='This minor entity defines the SQL error codes for a query. If a query was executed successfully, the error code is empty.'
;