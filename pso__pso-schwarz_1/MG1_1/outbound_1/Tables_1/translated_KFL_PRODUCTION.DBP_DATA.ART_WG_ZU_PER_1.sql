CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_WG_ZU_PER_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
DAT_VON DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig);Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)Regel: Neuer Artikel_1 -> Counter +1'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
WG_ID INTEGER NOT NULL OPTIONS(description='Warengruppe'),
DAT_BIS DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode'),
WUG_ID INTEGER NOT NULL OPTIONS(description='Warenuntergruppe'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
) OPTIONS(description='TP2_AIS - Artikel_1 Warengruppe Zuordnung');