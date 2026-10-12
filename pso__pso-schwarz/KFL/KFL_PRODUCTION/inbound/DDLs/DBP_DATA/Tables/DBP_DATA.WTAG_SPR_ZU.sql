create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.WTAG_SPR_ZU (
	WTAG_ID NUMBER(38,0) NOT NULL COMMENT 'Wochentag ID, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	WTAG_BEZ VARCHAR(20) COLLATE 'en-ci' COMMENT 'Bezeichnung des Wochentags in den DWH-Sprachen',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_WTAG_SPR_ZU primary key (WTAG_ID, SPR_ID)
)COMMENT='TP1_MIS - Bezeichnung der Wochentage in den DWH-Sprachen'
;
