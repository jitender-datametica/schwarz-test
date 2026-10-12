CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_GTIN_ZU_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
ALTNV_MENGE_EINH_ID STRING(3) NOT NULL OPTIONS(description='Mengeneinheit für Anzeige'),
LFD_NR INTEGER NOT NULL OPTIONS(description='Laufende Nummer'),
GTIN_ID INTEGER NOT NULL OPTIONS(description='Global Trade Item_2 Number (GTIN)'),
GTIN_TYP_KZ STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='Nummerntyp der Global Trade Item_2 Number (z.B. G1 = Hersteller GTIN)'),
HAUPT_GTIN_FG INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Kennzeichen Haupt-GTIN (x=1)'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_ID, ALTNV_MENGE_EINH_ID, LFD_NR) NOT ENFORCED
) OPTIONS(description='EK-INTEGER - Zuordnungstabelle GTIN (Global Trade Item_2 Number) zum Artikel_2 in SAP PR1 - MEAN_2');