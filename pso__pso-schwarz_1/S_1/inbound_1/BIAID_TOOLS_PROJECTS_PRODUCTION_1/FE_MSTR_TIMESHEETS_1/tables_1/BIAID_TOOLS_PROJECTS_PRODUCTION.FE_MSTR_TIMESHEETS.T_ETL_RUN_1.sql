create or replace TABLE BIAID_TOOLS_PROJECTS_PRODUCTION.FE_MSTR_TIMESHEETS.T_ETL_RUN_1 (
	ETL_RUN_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the ETL job execution, combined with SRC_FILE_NAME idetifies a row within the table uniquely',
	SRC_FILE_NAME VARCHAR(500) NOT NULL COMMENT 'Name of the source file that cotains the data we are importing',
	JOB_TYPE VARCHAR(50) COMMENT ' Initial Load (if we import the timesheet entries for the first time) or Update if we load corrected values',
	FILE_NEEDS_RELOAD_FG NUMBER(38,0) DEFAULT 0 COMMENT 'Flag indicates if same file needs to be reloaded in another run. Set to 1 if you want to reload a file',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Point in time when this row was created in the database',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Point in time of the last update of this record',
	constraint PK_T_ETL_RUN primary key (ETL_RUN_ID, SRC_FILE_NAME)
)COMMENT='A table that keeps track of ETL process executions'
;