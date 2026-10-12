create or replace TABLE LDL_DATA_PRODUCTION.META.T_WORKLOAD_CLASS (
	WORKLOAD_CLASS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the workload. E.g. customer segmentation queries, data mining, etc.',
	WORKLOAD_CLASS_DESCR VARCHAR(250) NOT NULL COMMENT 'A text field describing the structure and the purpose of the workload.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_WORKLOAD_CLASS primary key (WORKLOAD_CLASS_CD)
)COMMENT='Queries the serve the same purpose can be grouped to a workload, e.g. based on the user who submits the query, the purpose of the query or the objects which get accessed.'
;