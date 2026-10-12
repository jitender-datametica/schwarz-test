create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ARTKZ_LEAD_2 (
	LEAD_ID NUMBER(38,0) NOT NULL COMMENT 'Artikelkennzeichen leader 1 ist Leader, sonst 0',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	LEAD_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Bezeichnung Leader',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTKZ_LEAD primary key (LEAD_ID, MANDANT_ID, SPR_ID)
)COMMENT='TP2_AIS - Lookuptabelle des Artikelkennzeichens Leaderartikel'
;
