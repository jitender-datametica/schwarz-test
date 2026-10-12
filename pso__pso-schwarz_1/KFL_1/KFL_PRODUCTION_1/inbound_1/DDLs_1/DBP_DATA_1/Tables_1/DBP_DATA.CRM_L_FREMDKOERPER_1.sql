create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_L_FREMDKOERPER_1 (
	CRM_FREMDKOERPER_ID NUMBER(38,0) NOT NULL COMMENT 'Art_1 der Verunreinigung ID',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_L_FREMDKOERPER primary key (CRM_FREMDKOERPER_ID)
)COMMENT='KMR - Lookup für Fremdkörper - MS Dynamics CRM'
;
