create or replace TABLE UGS_ARIS_PRODUCTION.CORE.T_DIM_PROCESS_WORKFLOW_STATUS_LNG_2 (
	PROCESS_WORKFLOW_STATUS_CD VARCHAR(5) NOT NULL COMMENT 'The code for the step in the approval process of a process.',
	LNG_CD VARCHAR(2) NOT NULL COMMENT 'The code for the language according to ISO-639-1. E.g. \"DE\" for German.',
	PROCESS_WORKFLOW_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description in the language indicated by the language code for the approval step of a process.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.'
)COMMENT='The workflow status_2 details the process status_2 by defining the approval steps which are required before a process can be rolled out. This table contains the corresponding textual descriptions in various languages. There is one record for each type of process model and language.'
;