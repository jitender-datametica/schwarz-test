create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_VORGANG_TOUCHPOINT_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH.',
	CRM_VORGANG_ID VARCHAR(36) NOT NULL COMMENT 'Ticket-ID.',
	TOUCHPOINT_ID NUMBER(38,0) NOT NULL COMMENT 'Several count-fields that describe the amount of times that the ticket has been in each touchpoint (department, customer, store etc.).',
	TOUCHPOINT_COUNT NUMBER(38,0) COMMENT 'Several count-fields that describe the amount of times that the ticket has been in each touchpoint (department, customer, store etc.).',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_VORGANG_TOUCHPOINT_ZU primary key (CRM_VORGANG_ID, TOUCHPOINT_ID, MANDANT_ID)
)COMMENT='Assignment of respective touchpoints (touchpoints are departments the ticket gets sent to during the solution process) to ticket number, including counts.'
;
