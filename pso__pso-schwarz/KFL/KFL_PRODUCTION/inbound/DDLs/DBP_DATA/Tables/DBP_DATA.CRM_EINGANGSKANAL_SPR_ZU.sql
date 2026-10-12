create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_EINGANGSKANAL_SPR_ZU (
	CRM_EINGANGSKANAL_ID NUMBER(38,0) NOT NULL COMMENT 'Eingangskanal ID - z.B. Telefon, Email, etc.',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	CRM_EINGANGSKANAL_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Eingangskanal Bezeichnung DWH generiert',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_EINGANGSKANAL_SPR_ZU primary key (CRM_EINGANGSKANAL_ID, SPR_ID)
)COMMENT='KMR - Sprachzuordnungstabelle Eingangskanal - MS Dynamics CRM'
;
