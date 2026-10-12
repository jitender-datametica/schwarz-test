create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ART_BACKEN_SPR_ZU_1 (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache\n            ',
	ART_BACKEN_BEZ VARCHAR(50) COLLATE 'en-ci' COMMENT 'Artikelbezeichnung speziell für den Backshop',
	FEIERABEND_FG NUMBER(38,0) NOT NULL DEFAULT 0,
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_BACKEN_SPR_ZU primary key (ART_ID, MANDANT_ID, SPR_ID)
)COMMENT='VIS Backshop - Im Backshop werden von den Stammdaten abweichende Artikelbezeichnungen verwendet'
;
