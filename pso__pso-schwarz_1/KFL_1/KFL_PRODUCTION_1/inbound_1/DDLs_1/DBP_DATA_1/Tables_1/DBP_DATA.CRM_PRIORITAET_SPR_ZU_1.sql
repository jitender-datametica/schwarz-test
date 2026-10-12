create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_PRIORITAET_SPR_ZU_1 (
	CRM_PRIORITAET_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Priorität, niedrig, mittel, hoch',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	CRM_PRIORITAET_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Priorität Bezeichnung DWH generiert',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_PRIORITAET_SPR_ZU primary key (CRM_PRIORITAET_ID, SPR_ID)
)COMMENT='KMR - Sprachzuordnungstabelle Priorität - MS Dynamics CRM'
;
