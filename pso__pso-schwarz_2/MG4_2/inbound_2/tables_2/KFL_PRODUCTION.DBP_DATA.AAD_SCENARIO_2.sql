create or replace TABLE KFL_PRODUCTION.DBP_DATA.AAD_SCENARIO_2 (
	SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the Scenario',
	SCENARIO_GRP_ID NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the Scenariogroup',
	DWH_CREATED_TMSP TIMESTAMP_NTZ(9) COMMENT 'Auto generate by Insert',
	DWH_UPDATED_TMSP TIMESTAMP_NTZ(9) COMMENT 'Auto generate by Update',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AAD_SCENARIO primary key (SCENARIO_ID)
)COMMENT=' Contains the scenario and scenariogroup mapping'
;