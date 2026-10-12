create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_L_GUTSCHEIN_GRUND_1 (
	CRM_GUTSCHEIN_GRUND_ID NUMBER(38,0) NOT NULL COMMENT 'Grund der Gutscheinausgabe ID',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_L_GUTSCHEIN_GRUND primary key (CRM_GUTSCHEIN_GRUND_ID)
)COMMENT='KMR - Lookup für Gutscheinausgabegrund - MS Dynamics CRM'
;