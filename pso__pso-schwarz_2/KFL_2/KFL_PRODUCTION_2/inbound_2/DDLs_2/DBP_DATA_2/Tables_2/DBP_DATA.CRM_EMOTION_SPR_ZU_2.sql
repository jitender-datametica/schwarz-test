create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.CRM_EMOTION_SPR_ZU_2 (
	CRM_EMOTION_ID NUMBER(38,0) NOT NULL COMMENT 'Emotion ID (GUID) aus CRM',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	EMOTION_BEZ VARCHAR(100) NOT NULL COLLATE 'en-ci' COMMENT 'Emotion text',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_EMOTION_SPR_ZU primary key (CRM_EMOTION_ID, SPR_ID)
)COMMENT='KMR - Enthält die möglichen Bewertungen der Kundenzufriedentheit aus der CRM Entität kl_emotion - MS Dynamics CRM'
;
