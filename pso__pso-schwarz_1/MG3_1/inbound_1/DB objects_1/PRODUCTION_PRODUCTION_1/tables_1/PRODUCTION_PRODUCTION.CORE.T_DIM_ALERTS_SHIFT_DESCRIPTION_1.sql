create or replace TABLE PRODUCTION_PRODUCTION.CORE.T_DIM_ALERTS_SHIFT_DESCRIPTION_1 (
	ALERTS_SHIFT_DESCRIPTION_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier for the shift description.',
	ALERTS_DAY_SHIFT_DESC VARCHAR(16777216) NOT NULL COMMENT 'A textual default description for the shift in German',
	ALERTS_DAY_SHIFT_DESC_DE VARCHAR(16777216) NOT NULL COMMENT 'A textual description for the shift in German',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_T_DIM_ALERTS_SHIFT_DESCRIPT primary key (ALERTS_SHIFT_DESCRIPTION_ID)
)COMMENT='Dimension for describing the differnt shift types.'
;