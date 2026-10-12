create or replace TABLE LDL_DATA_PRODUCTION.META.T_SUPPORT_GROUP (
	SUPPORT_GRP_CD VARCHAR(20) NOT NULL COMMENT 'The code which identifies the support group.',
	SUPPORT_GRP_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the support group.',
	SOLUTION_CD VARCHAR(20) NOT NULL COMMENT 'The code which identifies the solution.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_SUPPORT_GROUP primary key (SUPPORT_GRP_CD)
)COMMENT='A support group is responsible for resolving a data quality issue'
;