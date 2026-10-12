create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_SCHAEDLINGSART_SPR_ZU (
	CRM_SCHAEDLINGSART_ID NUMBER(38,0) NOT NULL COMMENT 'Schädlingsart ID',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	CRM_SCHAEDLINGSART_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Schädlingsart Bezeichnung DWH generiert',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_SCHAEDLINGSART_SPR_ZU primary key (CRM_SCHAEDLINGSART_ID, SPR_ID)
)COMMENT='KMR - Sprachzuordnungstabelle Schädlingsart - MS Dynamics CRM'
;