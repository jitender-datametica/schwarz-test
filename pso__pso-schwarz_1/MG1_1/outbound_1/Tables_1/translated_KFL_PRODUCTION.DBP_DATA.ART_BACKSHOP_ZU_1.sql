CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_BACKSHOP_ZU_1 (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
BESTELL_ART_ID INTEGER NOT NULL
OPTIONS(description='Bestellartikel = ein Artikel_1 der WG 291, der nicht verkauft wird, sondern lediglich zur Produktion eines anderen Artikels dient. Referenz zur Tabelle art_1'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ART_ID, MANDANT_ID, BESTELL_ART_ID) NOT ENFORCED
) OPTIONS(description='VIS Backshop -Zuordnung der Backshop-Verkaufsartikel zu den Backshop-Bestellartikeln');