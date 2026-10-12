create or replace TABLE LDL_DATA_PRODUCTION.META.T_REJECT_LOG (
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the execution of an ETL job.',
	REJECTED_REC_TXT VARCHAR(1000) NOT NULL COMMENT 'The record which has been rejected, as an unformatted text string.',
	REJECT_REASON_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the reason, why an ETL job has excluded a record from further processing.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_REJECT_LOG primary key (LOAD_ID, REJECTED_REC_TXT)
)COMMENT='A log table containing all records which had to be excluded from further processing. Records can be rejected because of the following reasons: The record cannot be read, the record structure is invalid or the key of the records cannot be interpreted.'
;