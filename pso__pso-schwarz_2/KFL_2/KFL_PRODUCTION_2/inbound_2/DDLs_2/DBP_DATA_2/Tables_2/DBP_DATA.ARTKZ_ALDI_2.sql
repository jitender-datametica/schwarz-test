create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ARTKZ_ALDI_2 (
	ALDI_ID NUMBER(38,0) NOT NULL COMMENT 'Kennzeichnet, in welcher/ welchen Vertriebsschiene(n) ein Artikel_2 das Aldi Kennzeichen besitzt, kann sich auf eine_2 oder mehrere Vertriebsschienen beziehen',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache\n            ',
	ALDI_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Bezeichnung des Artikelkennzeichens Aldi (z.Bsp, Nord, Nord und West, ...)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTKZ_ALDI primary key (ALDI_ID, MANDANT_ID)
)COMMENT='TP2_AIS - Lookup Tabelle fuer Artikelkennzeichen Aldi'
;
