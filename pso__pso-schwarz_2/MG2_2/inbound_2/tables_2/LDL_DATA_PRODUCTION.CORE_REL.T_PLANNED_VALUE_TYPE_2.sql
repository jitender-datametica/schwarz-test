create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_PLANNED_VALUE_TYPE_2 (
	PLANNED_VAL_TYPE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the kind of value for which a plan is made. E.g. a forecast for revenue or customer count.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PLANNED_VAL_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the kind of value for which a plan is made.',
	PLANNED_VAL_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The number which identifies the kind of value for which a plan is made in the planning tool. E.g. 157 for net revenue.',
	PLANNED_VAL_ROLE_CD VARCHAR(20) COMMENT 'The code which identifies the role or context for which the value is planned.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	PLANNING_PROCESS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the planning process which defines this planned value type.',
	constraint PK_T_PLANNED_VALUE_TYPE primary key (PLANNED_VAL_TYPE_SID, LANG_CD)
)COMMENT='This minor entity defines the kind of value for which a plan is made. E.g. a forecast for revenue or customer count.'
;