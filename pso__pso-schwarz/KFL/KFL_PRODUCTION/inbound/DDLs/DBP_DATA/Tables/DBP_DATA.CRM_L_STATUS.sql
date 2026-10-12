create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_L_STATUS (
	CRM_STATUS_ID NUMBER(38,0) NOT NULL COMMENT 'Ticket Status ID z. B. Abgeschlossen',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_L_STATUS primary key (CRM_STATUS_ID)
)COMMENT='KMR - Lookup für den Vorgangsstatus - MS Dynamics CRM'
;
