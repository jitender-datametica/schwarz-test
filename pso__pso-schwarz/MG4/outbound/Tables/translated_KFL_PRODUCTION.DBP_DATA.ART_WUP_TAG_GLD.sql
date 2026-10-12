CREATE OR REPLACE TABLE kfl_production_dbp_data.art_wup_tag_gld (
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
ek_gld NUMERIC(18,4)
OPTIONS(description='Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Hier aus mseg abgeleitet.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat) NOT ENFORCED
)
OPTIONS(description='AIS_KMO - Zur Anreicherung der Tabelle artbew mit gld. Die Daten werden aus lagerbew_det gewonnen und für begrenzte Zeit in dieser Tabelle abgelegt - MULTISET.');