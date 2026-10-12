DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ART_WUP_ZU_PER;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_WUP_ZU_PER (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WUP_ID INTEGER NOT NULL
OPTIONS(description='\"Der\"\"WUP\"\" beinhaltet Märkte und Läger. WUP=WarenUmschlagsPlatz\n\n            Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum\n            '),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT_VON DATE NOT NULL OPTIONS(description='Datum wann ein Artikel zum ersten Mal in einem Markt gelistet ist'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
BEZUGSWEG_ID INTEGER
OPTIONS(description='Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
LISTUNG_ID INTEGER
OPTIONS(description='kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Der erste Eintrag erfolgt immer aufgrund einer Listung, bei Auslistung erfolgt  ein weiterer Eintrag mit 0. Die column ist wegen art_list_wup_zu_per eigentlich obsolet'),
VK_BRUTTO NUMERIC(9,3),
DAT_BIS DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT\n            '),
KDIS INTEGER
OPTIONS(description='kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel ist über den normalen Weg bestellbar, 1: der Artikel wird  zugeteilt'),
WRG_ID STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, NB_ID, DAT_VON, ART_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID
OPTIONS(description='TP2 AIS - Artikel-Markt-Zuordnung - MULTISET\t\n             Enthält Informationen, wie Artikel den Märkten zugeordnet sind, u.a. Listung, Bezugsweg und Normal-Verkaufspreise. Keine Information über Sonderaktionen enthalten');