create or replace TABLE KFL_PRODUCTION.DBP_DATA.AAD_SCENARIO_DEACTIVATION_1 (
	SCENARIO_ID NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the Scenario',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
	DWH_CREATED_TMSP TIMESTAMP_NTZ(9) COMMENT 'Auto generate by Insert',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AAD_SCENARIO_DEACTIVATION primary key (SCENARIO_ID, MANDANT_ID)
)COMMENT='Contains information which AAD fraud scenarios are deactivated for which countries (mandant_id)'
;