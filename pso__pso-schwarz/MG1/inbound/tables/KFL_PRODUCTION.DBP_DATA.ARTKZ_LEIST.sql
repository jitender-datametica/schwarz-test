create or replace TABLE KFL_PRODUCTION.DBP_DATA.ARTKZ_LEIST (
	LEIST_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Artikelkennzeichen Leistungsstark Food',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache\n            ',
	LEIST_BEZ VARCHAR(40) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Leistungsstärke Food Bezeichnung.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTKZ_LEIST primary key (LEIST_ID, MANDANT_ID)
)COMMENT='TP2_AIS - Lookuptabelle des Artikelkennzeichens leistungsstark'
;