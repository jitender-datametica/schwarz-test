create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_PROZESS_SPR_ZU (
	CRM_PROZESS_ID NUMBER(38,0) NOT NULL COMMENT 'Prozess ID (GUID) aus CRM - oberste Stuffe der Hierarchie',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	PROZESS_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Bezeichnung des Prozesses aus CRM',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_PROZESS_SPR_ZU primary key (CRM_PROZESS_ID, SPR_ID)
)COMMENT='KMR - Oberste Ebene der CRM Hierarchie - MS Dynamics CRM'
;