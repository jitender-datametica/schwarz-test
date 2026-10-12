DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ART_WUP_LISTUNG_KJWO;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_WUP_LISTUNG_KJWO (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
KJWO INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
KREISTYP_GRUPPE_ID STRING(4) COLLATE 'und:ci' OPTIONS(description='Region / Gruppierung Kreistypen'),
LISTUNG_ID INTEGER
OPTIONS(description='kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Der erste Eintrag erfolgt immer aufgrund einer Listung, bei Auslistung erfolgt  ein weiterer Eintrag mit 0. Die column ist wegen art_list_wup_zu_per eigentlich obsolet'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_ID, WG_ID, WUP_ID, NB_ID, KJWO) NOT ENFORCED
) CLUSTER BY MANDANT_ID, KJWO
OPTIONS(description='AIS - Artikellistung pro Markt / Kalenderwoche');