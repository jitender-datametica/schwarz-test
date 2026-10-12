create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_PROTECTION_LEVEL_1 (
	DATA_PROT_LVL_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way, how data objects need to be protected from unauthorized access. E.g. it labels personally identifiable information (PII) and data that needs to be protected for competitive reasons.',
	DATA_PROT_LVL_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the way, how data objects need to be protected from unauthorized access',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_PROTECTION_LEVEL primary key (DATA_PROT_LVL_CD)
)COMMENT='The data protection level defines how data objects need to be protected from unauthorized access. E.g. it labels personally identifiable information (PII) and data that needs to be protected for competitive reasons.'
;