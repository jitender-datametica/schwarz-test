create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_STATUS_SPR_ZU_2 (
	CRM_STATUS_ID NUMBER(38,0) NOT NULL COMMENT 'Ticket Status_2 ID z. B. Abgeschlossen',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	CRM_STATUS_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Status_2 Bezeichnung DWH generiert',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_STATUS_SPR_ZU primary key (CRM_STATUS_ID, SPR_ID)
)COMMENT='KMR - Sprachzuordnungstabelle Statuscode - MS Dynamics CRM'
;
