create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_EIGENMARKE_SPR_ZU_1 (
	CRM_EIGENMARKE_ID NUMBER(38,0) NOT NULL COMMENT 'Eigenmarke ID',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	CRM_EIGENMARKE_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Eigenmarke Bezeichnung DWH generiert',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_EIGENMARKE_SPR_ZU primary key (CRM_EIGENMARKE_ID, SPR_ID)
)COMMENT='KMR - Sprachzuordnungstabelle Eigenmarke - MS Dynamics CRM'
;