create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_GUTSCHEIN_GRUND_SPR_ZU (
	CRM_GUTSCHEIN_GRUND_ID NUMBER(38,0) NOT NULL COMMENT 'Grund der Gutscheinausgabe ID',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	CRM_GUTSCHEIN_GRUND_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Grund für Gutschein Bezeichnung DWH generiert',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_GUTSCHEIN_GRUND_SPR_ZU primary key (CRM_GUTSCHEIN_GRUND_ID, SPR_ID)
)COMMENT='KMR - Sprachzuordnungstabelle Grund für Gutscheine aus CRM - MS Dynamics CRM'
;