create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_TOUCHPOINT_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH.',
	TOUCHPOINT_ID NUMBER(38,0) NOT NULL COMMENT 'Several count-fields that describe the amount of times that the ticket has been in each touchpoint (department, customer, store etc.).',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Language ID.',
	TOUCHPOINT_BEZ VARCHAR(80) COMMENT 'Description of each touchpoint ID.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_TOUCHPOINT_SPR_ZU primary key (TOUCHPOINT_ID, SPR_ID, MANDANT_ID)
)COMMENT='spr_zu-table for touchpoints (touchpoints are departments the ticket gets sent to during the solution process).'
;
