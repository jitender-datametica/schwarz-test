create or replace TABLE PRODUCTION_PRODUCTION.CORE.T_DIM_ALERTS_PRIORITY (
	ALERTS_PRIORITY_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for the alarm priorities (also containing inactive components)',
	ALERTS_PRIORITY_DESC VARCHAR(16777216) NOT NULL COMMENT 'A textual default description for the arlarm priority in German',
	ALERTS_PRIORITY_DESC_DE VARCHAR(16777216) NOT NULL COMMENT 'A textual description for the arlarm priority in German',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_T_DIM_ALERTS_PRIORITY primary key (ALERTS_PRIORITY_ID)
)COMMENT='Dimension table for all translations regarding alarm priority codeing.'
;