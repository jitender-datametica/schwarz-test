CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_BACKPROGRAMM_ZU (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
BACK_PROGRAMM_ID INTEGER NOT NULL OPTIONS(description='ID des Backprogramms aus bake_program. Numerischer Wert'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ART_ID, MANDANT_ID, BACK_PROGRAMM_ID) NOT ENFORCED
)
OPTIONS(description='VIS Backshop - Diese Tabelle ordnet den Artikeln die Backprogramme zu. Quelle ist die SAP-Klassenbibliothek');