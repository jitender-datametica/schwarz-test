create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ARTKZ_LOESCH_1 (
	LOESCH_ID VARCHAR(2) NOT NULL COMMENT 'ID des Loeschkennzeichens, z.Bsp. L fuer logisch geloeschte Artikel_1',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache.',
	LOESCH_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Sprachabhaengige Bezeichnung des Loeschkennzeichens',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ARTKZ_LOESCH primary key (MANDANT_ID, LOESCH_ID, SPR_ID)
)COMMENT='TP2_AIS - Lookuptabelle des Artikelkennzeichens Loeschartikel'
;
