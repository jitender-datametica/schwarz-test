create or replace TABLE UGS_ARIS_PRODUCTION.CORE.T_DIM_EMPLOYMENT_POSITION_2 (
	DWH_TENANT_CD VARCHAR(8) NOT NULL COMMENT 'The code for the data warehoue tenant.',
	EMP_POS_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the employment position.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	EMP_POS_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the employment positon.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(100) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.'
)COMMENT='An employment position is a job role within the Schwarz Group, typically associated with certain responsibilities and / or rights. An employment position is usually filled by an employee_2 (or possibly an external contractor). The assignment of an employee_2 to an employment position may change over time, and an employment position may be vacant for a certain period of time. The relation between an employment position and an employee_2 is not necessarily 1:1. An employment position might be filled by two (part-time) employees, or an employee_2 may work in two different positions.'
;