DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ETL.AWP_TMP_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ETL.AWP_TMP_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
WUP_ID INTEGER NOT NULL
OPTIONS(description='\"Der\"\"WUP_2\"\" beinhaltet Märkte und Läger. WUP_2=WarenUmschlagsPlatz\n\n            Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum\n            '),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT_VON DATE NOT NULL OPTIONS(description='Datum wann ein Artikel_2 zum ersten Mal in einem Markt gelistet ist'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
BEZUGSWEG_ID INTEGER
OPTIONS(description='Kennzeichnet, ob der Artikel_2 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
LISTUNG_ID INTEGER
OPTIONS(description='kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Der erste Eintrag erfolgt immer aufgrund einer Listung, bei Auslistung erfolgt  ein weiterer Eintrag mit 0. Die column ist wegen art_list_wup_zu_per_2 eigentlich obsolet'),
VK_BRUTTO NUMERIC(9,3),
DAT_BIS DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT\n            '),
KDIS INTEGER
OPTIONS(description='kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel_2 ist über den normalen Weg bestellbar, 1: der Artikel_2 wird  zugeteilt'),
WRG_ID STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, NB_ID, DAT_VON, ART_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID;