DROP TABLE IF EXISTS kfl_production_dbp_data.art_wup_listung_kjwo;
CREATE OR REPLACE TABLE kfl_production_dbp_data.art_wup_listung_kjwo (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wg_id INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
kjwo INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
kreistyp_gruppe_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Region / Gruppierung Kreistypen'),
listung_id INTEGER
OPTIONS(description='kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Der erste Eintrag erfolgt immer aufgrund einer Listung, bei Auslistung erfolgt  ein weiterer Eintrag mit 0. Die column ist wegen art_list_wup_zu_per eigentlich obsolet'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wg_id, wup_id, nb_id, kjwo) NOT ENFORCED
) CLUSTER BY mandant_id, kjwo
OPTIONS(description='AIS - Artikellistung pro Markt / Kalenderwoche');