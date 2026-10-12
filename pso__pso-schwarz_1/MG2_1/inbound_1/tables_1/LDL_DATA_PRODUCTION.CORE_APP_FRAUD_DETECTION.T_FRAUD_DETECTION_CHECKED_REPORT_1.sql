create or replace TABLE LDL_DATA_PRODUCTION.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_CHECKED_REPORT_1 (
	INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organizatio (store or sales_1 company/VGES)',
	REQUEST_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time when this record requested by the MicroStrategy-User.',
	REPORT_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of MicroStrategy Report',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	CHECKED_BY_USER_NAME VARCHAR(100) NOT NULL COMMENT 'The end user, who sets the audit flag',
	COMMENT_BY_USER VARCHAR(100) COMMENT 'The comment of the user',
	constraint PK_T_FRAUD_DETECTION_CHECKED_REPORT primary key (INT_ORG_SID, REQUEST_TMSP, REPORT_ID)
)COMMENT='Keeps the fraud detection audit list, to know which organisation is approved for which report'
;