CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_SPR_ZU_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig);Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)Regel: Neuer Artikel_1 -> Counter +1'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
ART_BEZ STRING(200) COLLATE 'und:ci' OPTIONS(description='Artikelbezeichnung'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
) OPTIONS(description='TP2_AIS - Sprachabhaengige Bezeichnungen der Artikel_1');