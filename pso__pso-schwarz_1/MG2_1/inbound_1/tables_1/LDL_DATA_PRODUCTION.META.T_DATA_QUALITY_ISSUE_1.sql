create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_QUALITY_ISSUE_1 (
	DQ_ISSUE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the data quality issue.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DQ_ISSUE_NAME VARCHAR(250) NOT NULL COMMENT 'The name by which the data quality issue is known.',
	DQ_ISSUE_CREATION_DT DATE NOT NULL COMMENT 'The date when the data quality issue was first observed. (In case the issue is closed and re_1-opened after some time, the creation date does not change.)',
	DQ_ISSUE_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the resolution status_1 of a data quality issue.',
	DQ_ISSUE_REASON_CD VARCHAR(20) COMMENT 'The code identifying the root cause for a data quality issue.',
	SUPPORT_GRP_CD VARCHAR(20) COMMENT 'The code which identifies the support group.',
	ANALYSIS_COMMENT_TXT VARCHAR(32000) COMMENT 'A free text comment to the analysis of the data quality issue.',
	RESOLUTION_COMMENT_TXT VARCHAR(32000) COMMENT 'A free text comment to the resolution of the data quality issue.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_QUALITY_ISSUE primary key (DQ_ISSUE_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A problem caused by insufficient data quality. A data quality issue is documented by one or several data quality checks. An issue may be resolved and re_1-opened some time later.'
;