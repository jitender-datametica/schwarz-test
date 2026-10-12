create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PLANNING_PROCESS (
	PLANNING_PROCESS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the planning process.',
	PLANNING_PROCESS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the planning process.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_PLANNING_PROCESS primary key (PLANNING_PROCESS_CD)
)COMMENT='A planning process is an administrative activity which defines a set of planned values. E.g. the short-term staff planning in stores or the annual planning for the next business year. The same type of value (e.g. net revenue) can be planned by several planning processes, however for the model these are different planned value types. I.e. each value is planned by exactly one planning process.'
;