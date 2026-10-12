create or replace TABLE LDL_DATA_PRODUCTION.META.T_QUERY (
	QUERY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the query.',
	QUERY_START_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time, when the query was started.',
	QUERY_END_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time, when the query finished.',
	SQL_TXT VARCHAR(1000) NOT NULL COMMENT 'The SQL statement.',
	USER_NAME VARCHAR(100) COMMENT 'The name of the user that submitted the query.',
	SESSION_NR VARCHAR(20) COMMENT 'The number which identifies a session on a system at a given point in time. (Session numbers may be re-used.)',
	ROLE_NAME VARCHAR(100) COMMENT 'The name of the role under which the query was executed.',
	SNOWFLAKE_WH_NAME VARCHAR(100) COMMENT 'The name for the compute resource on Snowflake which executes a query.',
	WORKLOAD_CLASS_CD VARCHAR(20) COMMENT 'The code identifying the workload. E.g. customer segmentation queries, data mining, etc.',
	QUERY_ERROR_CD VARCHAR(20) COMMENT 'The error code of the query, as defined by the database engine. If the query was executed successfully, the error code is empty.',
	QUERY_ERROR_TXT VARCHAR(1000) COMMENT 'The error message',
	RETURNED_REC_CNT NUMBER(38,0) COMMENT 'The number of records which were returned to the user as the result of the query.',
	INSERTED_REC_CNT NUMBER(38,0) COMMENT 'The number of records which were inserted as the result of the query.',
	DELETED_REC_CNT NUMBER(38,0) COMMENT 'The number of records which were deleted as the result of the query.',
	UPDATED_REC_CNT NUMBER(38,0) COMMENT 'The number of records which were updated as the result of the query.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_QUERY primary key (QUERY_SID)
)COMMENT='A query is a piece of SQL (or a similar language) which is executed against a database management system.'
;