CREATE TABLE DBP_DATA.ART_SPR_ZU_2 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	ART_ID INTEGER NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig);Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)Regel: Neuer Artikel_2 -> Counter +1',
	SPR_ID INTEGER NOT NULL COMMENT 'ID der Sprache',
	ART_BEZ VARCHAR(200) COLLATE 'en-ci' COMMENT 'Artikelbezeichnung',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='TP2_AIS - Sprachabhaengige Bezeichnungen der Artikel_2'
;