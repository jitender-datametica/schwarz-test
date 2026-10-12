create or replace TABLE UGS_ARIS_PRODUCTION.CORE.T_FACT_PROCESS_TO_STORE_AREA_1 cluster by (dwh_tenant_cd)(
	DWH_TENANT_CD VARCHAR(8) NOT NULL COMMENT 'The code for the data warehoue tenant.',
	PROCESS_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the process model.',
	STORE_AREA_CD VARCHAR(20) NOT NULL COMMENT 'The code for an area in a store, such as fresh food, meat, non-food or the cash register area.',
	DWH_VALID_FG BOOLEAN,
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(100) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.'
)COMMENT='This bridge table shows which store areas are affected by a process.'
;