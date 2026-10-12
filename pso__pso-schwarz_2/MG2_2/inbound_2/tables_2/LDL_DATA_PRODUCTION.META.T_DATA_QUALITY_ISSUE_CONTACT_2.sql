create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_QUALITY_ISSUE_CONTACT_2 (
	DQ_ISSUE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the data quality issue.',
	EMP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the employee.',
	DQ_ISSUE_CONTACT_ROLE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the role, which the contact_2 person plays in the context of the data quality issue. E.g. an employee_2 may be the primary contact_2 for analyzing the issue or a secondary contact_2 for resolving the issue.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_QUALITY_ISSUE_CONTACT primary key (DQ_ISSUE_SID, EMP_SID, DWH_VALID_FROM_TMSP, DQ_ISSUE_CONTACT_ROLE_CD)
)COMMENT='Data quality issues get handled by various employees. There are people who analyze the problem, while other employees work on its resolution. This entity tracks the relation between a data quality issue and all employees which are involved in analyzing and resolving it.'
;