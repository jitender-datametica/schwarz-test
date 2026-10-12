create or replace TABLE LDL_DATA_PRODUCTION.META.T_SOLUTION_2 (
	SOLUTION_CD VARCHAR(20) NOT NULL COMMENT 'The code which identifies the solution.',
	SOLUTION_NAME VARCHAR(100) COMMENT 'The name by which the solution is known.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_SOLUTION primary key (SOLUTION_CD)
)COMMENT='A solution is an organizational unit_2 which is responsible for the collaboration of business and IT. A solution is responsible for handling data quality issues. It decides on the required steps to resolve the issue and to correct the data, as well as on measures that will prevent the problem from occurring again.'
;