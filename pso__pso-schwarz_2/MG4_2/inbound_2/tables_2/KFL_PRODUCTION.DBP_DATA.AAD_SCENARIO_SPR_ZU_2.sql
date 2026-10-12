create or replace TABLE KFL_PRODUCTION.DBP_DATA.AAD_SCENARIO_SPR_ZU_2 (
	SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the Scenario',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH - ein Mandant_2 pro Land.',
	SCENARIO_DESCR VARCHAR(255) COMMENT 'Scenario´s name in the corresponding language',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AAD_SCENARIO_SPR_ZU primary key (SCENARIO_ID, SPR_ID, MANDANT_ID)
)COMMENT=' Contains the description of the scenario in the corresponding languages'
;