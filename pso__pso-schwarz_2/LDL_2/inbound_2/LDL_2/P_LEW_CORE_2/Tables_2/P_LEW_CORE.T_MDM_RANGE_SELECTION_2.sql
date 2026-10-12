create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_MDM_RANGE_SELECTION_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'technical column required by the used ETL framework\n            static 7 for all rows',
	MDM_RANGE_SEL_SID NUMBER(38,0) NOT NULL COMMENT 'surrogate key NFPO range selection\n            CBX: CNT_PROGRAM.REF_NO',
	SRC_PROG_DOC_REF VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'identifier of the NFPO range selection\n            CBX: CNT_PROGRAM.REF_NO',
	RANGE_PLAN_CD VARCHAR(20) COLLATE 'en-ci' COMMENT 'logical  identifier of the NFPO range selection: sometimes technically 2 records for a logical range selection exist, but only one is active\n            CBX: CNT_PROGRAM.PROGRAM_NO',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',
	constraint PK_T_MDM_RANGE_SELECTION primary key (MDM_RANGE_SEL_SID)
)COMMENT='NFPO quarterly waves to define and order items\n             CBX: CNT_PROGRAM'
;
