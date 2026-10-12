create or replace TABLE UGS_ARIS_PRODUCTION.EVAL.T_FACT_INT_PROCESS_TARGET cluster by (dwh_tenant_cd)(
	DWH_TENANT_CD VARCHAR(8) NOT NULL COMMENT 'The code for the data warehoue tenant.',
	PROCESS_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the process model.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country organization to which the process model shall be rolled out.',
	DWH_VALID_FG BOOLEAN,
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(100) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.'
);