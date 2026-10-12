create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ARTKZ_DISPLAY_1 (
	DISPLAY_ID NUMBER(38,0) NOT NULL COMMENT 'Schlüssel des Artikelkennzeichens Display (0 = kein Displayartikel',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache\n            ',
	DISPLAY_BEZ VARCHAR(80) COLLATE 'en-ci' COMMENT 'Bezeichnung des Artikelkennzeichens Display',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTKZ_DISPLAY primary key (DISPLAY_ID, MANDANT_ID)
)COMMENT='TP2_AIS - Lookup Artikelkennzeichen Display'
;
