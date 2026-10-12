create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_L_PROZESS (
	CRM_PROZESS_ID NUMBER(38,0) NOT NULL COMMENT 'Prozess ID (GUID) aus CRM - oberste Stuffe der Hierarchie',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_L_PROZESS primary key (CRM_PROZESS_ID)
)COMMENT='KMR - Oberste Ebene der CRM Hierarchie - MS Dynamics CRM'
;
