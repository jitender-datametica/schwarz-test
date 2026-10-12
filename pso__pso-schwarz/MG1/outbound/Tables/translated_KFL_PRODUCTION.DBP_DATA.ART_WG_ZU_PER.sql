CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_WG_ZU_PER (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
DAT_VON DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig);Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)Regel: Neuer Artikel -> Counter +1'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
WG_ID INTEGER NOT NULL OPTIONS(description='Warengruppe'),
DAT_BIS DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode'),
WUG_ID INTEGER NOT NULL OPTIONS(description='Warenuntergruppe'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
) OPTIONS(description='TP2_AIS - Artikel Warengruppe Zuordnung');