create or replace TABLE LDL_DATA_PRODUCTION.META.T_BUSINESS_TERM_APPROVAL_STATUS_1 (
	APPROVAL_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the approval status_1 for a business term.',
	APPROVAL_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the approval status_1 for business terms.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_BUSINESS_TERM_APPROVAL_STATUS primary key (APPROVAL_STATUS_CD)
)COMMENT='This minor entity defines the approval levels for business terms. A business term may be a draft, approved or revoked.'
;