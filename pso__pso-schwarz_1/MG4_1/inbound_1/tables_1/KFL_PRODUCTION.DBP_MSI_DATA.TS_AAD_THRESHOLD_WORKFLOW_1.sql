create or replace TABLE KFL_PRODUCTION.DBP_MSI_DATA.TS_AAD_THRESHOLD_WORKFLOW_1 (
	THRESHOLD_REQUEST_ID NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the Request (Sequence)',
	DWH_CREATED_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp when this record (version) of the Request was created. ',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
	REGION_ID NUMBER(38,0) NOT NULL COMMENT 'Region_1 eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region_1 gebildet',
	SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the Scenario',
	SCENARIO_METRIC_ID NUMBER(38,0) NOT NULL COMMENT 'Unique identifier of the metric that is monitored in fraud detection scenarios',
	CREATOR_USER_ID VARCHAR(255) COMMENT 'AD name of the user who created the request',
	SCENARIO_METRIC_THRESHOLD_INIT_VAL NUMBER(18,4) COMMENT 'The current scenario threshold value, This is used for calculations',
	SCENARIO_METRIC_USER_VAL NUMBER(18,4) COMMENT 'The current scenario threshold value, This is used for calculations',
	REQUEST_STATUS_TYPE_ID NUMBER(38,0) COMMENT 'Id of the types of statuses a request can have: default 0=open, 1= approved, 2=rejected',
	CREATION_REASON_COMMENT_TXT VARCHAR(255) COMMENT 'Describes the justification entered by the applicant - why the request was created',
	APPROVER_COMMENT_TXT VARCHAR(255) COMMENT 'Comment entered by the person who approves the request',
	EXPIRATION_TMSP TIMESTAMP_NTZ(9) COMMENT 'Timestmap when at which point request expires and is no logner valid',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_AAD_THRESHOLD_WORKFLOW primary key (THRESHOLD_REQUEST_ID, DWH_CREATED_TMSP)
)COMMENT='Contains information about request to change values of metrics scenario metric thresholds.'
;