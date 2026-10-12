create or replace TABLE PRODUCTION_PRODUCTION.ETL.T_ETL_DIM_ALERTS_MESSAGE_1 (
	ALERTS_MESSAGE_ID NUMBER(38,0) NOT NULL COMMENT 'The alarm message number for an alarm',
	ALERTS_LOCATION_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for the alarm location_1 on which the alarm occured and where the station is located at.',
	ALERTS_PRIORITY_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for the alarm priorities (also containing inactive components)',
	ALERTS_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'Unique identifier for the alarm type (0 = unknown 1 = system created alarm; 2 = manually created alarm)',
	ALERTS_MESSAGE_DESC VARCHAR(16777216) NOT NULL COMMENT 'A textual default description for the alarm message in German',
	ALERTS_MESSAGE_DESC_DE VARCHAR(16777216) NOT NULL COMMENT 'A textual description for the alarm message in German',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_T_DIM_ALERTS_MESSAGE primary key (ALERTS_MESSAGE_ID)
);