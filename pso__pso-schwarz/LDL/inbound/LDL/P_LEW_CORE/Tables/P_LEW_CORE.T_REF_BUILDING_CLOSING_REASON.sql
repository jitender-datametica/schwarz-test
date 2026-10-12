create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_BUILDING_CLOSING_REASON cluster by (CLIENT_ID)(
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice',
	CLOSING_REASON_ID NUMBER(38,0) NOT NULL COMMENT 'IMS_ESB : identifier for the reason of closing : object.status-development.status.status-date.closing-reason-id',
	CLOSING_REASON_DESCR VARCHAR(100) COLLATE 'en-ci' COMMENT 'IMS_ESB : description for the reason of closing : initial load from business',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_REF_BUILDING_CLOSING_REASON primary key (CLIENT_ID, CLOSING_REASON_ID)
)COMMENT='$Revision: 0000 $. Description of the reason for closing a building (permanently or temporary)'
;
