CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_WUP_TAG_GLD (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
EK_GLD NUMERIC(18,4)
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Hier aus mseg abgeleitet.'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ART_ID, MANDANT_ID, WUP_ID, NB_ID, DAT) NOT ENFORCED
)
OPTIONS(description='AIS_KMO - Zur Anreicherung der Tabelle artbew mit gld. Die Daten werden aus lagerbew_det gewonnen und für begrenzte Zeit in dieser Tabelle abgelegt - MULTISET.');