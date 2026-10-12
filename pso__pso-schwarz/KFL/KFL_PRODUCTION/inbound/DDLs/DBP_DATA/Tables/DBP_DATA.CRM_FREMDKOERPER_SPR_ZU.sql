create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_FREMDKOERPER_SPR_ZU (
	CRM_FREMDKOERPER_ID NUMBER(38,0) NOT NULL COMMENT 'Art der Verunreinigung ID',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	CRM_FREMDKOERPER_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Fremdkörper Bezeichnung DWH generiert',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_FREMDKOERPER_SPR_ZU primary key (CRM_FREMDKOERPER_ID, SPR_ID)
)COMMENT='KMR - Sprachzuordnungstabelle Fremdkörper - MS Dynamics CRM'
;
