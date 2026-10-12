create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ARTKZ_POSTEN_1 (
	POSTEN_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache.',
	POSTEN_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Sprachabhaengige Bezeichnung des Postenkennzeichens.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTKZ_POSTEN primary key (POSTEN_ID, MANDANT_ID, SPR_ID)
)COMMENT='TP2_AIS - Lookuptabelle fuer das Artikelkennzeichen Postenartikel'
;
