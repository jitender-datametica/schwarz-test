create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_VORGANG_FREMDKOERPER_ZU_1 (
	CRM_VORGANG_ID VARCHAR(36) NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Vorgang ID (GUID) aus CRM',
	CRM_FREMDKOERPER_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Art_1 der Verunreinigung ID',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_VORGANG_FREMDKOERPER_ZU primary key (CRM_VORGANG_ID, CRM_FREMDKOERPER_ID)
)COMMENT='A relationship table that links crm_vorgang_1 and crm_l_fremdkoerper_1'
;
