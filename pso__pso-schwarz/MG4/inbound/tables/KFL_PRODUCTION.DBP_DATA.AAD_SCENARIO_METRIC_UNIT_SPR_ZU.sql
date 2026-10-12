create or replace TABLE KFL_PRODUCTION.DBP_DATA.AAD_SCENARIO_METRIC_UNIT_SPR_ZU (
	SCENARIO_METRIC_UNIT_ID NUMBER(38,0) NOT NULL COMMENT 'Unique identifier of the metric that is monitored in fraud detection scenarios',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land.',
	SCENARIO_METRIC_UNIT_DESCR VARCHAR(255) COMMENT 'Scenario´s metric unit name in the corresponding language',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AAD_SCENARIO_METRIC_UNIT_SPR_ZU primary key (SCENARIO_METRIC_UNIT_ID, SPR_ID, MANDANT_ID)
)COMMENT='Contains the description of the scenario metric units in the corresponding languages'
;