create or replace TABLE KFL_PRODUCTION.DBP_ETL.ART_SPR_ZU_TEMP_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig);Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)Regel: Neuer Artikel_2 -> Counter +1',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	ART_BEZ VARCHAR(200) COLLATE 'en-ci' COMMENT 'Artikelbezeichnung',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
);