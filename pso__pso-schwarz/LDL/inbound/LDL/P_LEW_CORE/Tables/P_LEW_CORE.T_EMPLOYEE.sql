create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_EMPLOYEE (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
	EMP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the employee.',
	EMP_NR VARCHAR(100) NOT NULL COMMENT 'Employee business number.',
	EMP_WORKFORCE_NR VARCHAR(100) COMMENT 'Employee workforce business number.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_EMPLOYEE primary key (EMP_SID)
)COMMENT='An employee is a person who works for the Schwarz Group. This includes full-time and part-time employees, as well as freelancers and external contractors.'
;
