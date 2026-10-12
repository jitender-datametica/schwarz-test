create or replace TABLE PRODUCTION_PRODUCTION.CORE.T_DIM_ALERTS_LOCATION_CLASSIFICATION_1 (
	ALERTS_LOCATION_CLASSIFICATION_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for the alarm location_1 classification on which the alarm occured and where the station is located at.',
	ALERTS_LOCATION_CLASSIFICATION_DESC VARCHAR(16777216) NOT NULL COMMENT 'A textual default description for the alarm location_1 classification in German',
	ALERTS_LOCATION_CLASSIFICATION_DESC_DE VARCHAR(16777216) NOT NULL COMMENT 'A textual description for the alarm location_1 classification in German',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_T_DIM_ALERTS_LOCATION_CLASS primary key (ALERTS_LOCATION_CLASSIFICATION_ID)
)COMMENT='Table to classify alarm locations within the BonGelati.'
;