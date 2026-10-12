DROP TABLE IF EXISTS kfl_production_dbp_data.art_wup_zu_per_2;
CREATE OR REPLACE TABLE kfl_production_dbp_data.art_wup_zu_per_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id INTEGER NOT NULL
OPTIONS(description='\"Der\"\"WUP_2\"\" beinhaltet Märkte und Läger. WUP_2=WarenUmschlagsPlatz\n\n            Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum\n            '),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_von DATE NOT NULL OPTIONS(description='Datum wann ein Artikel_2 zum ersten Mal in einem Markt gelistet ist'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
bezugsweg_id INTEGER
OPTIONS(description='Kennzeichnet, ob der Artikel_2 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
listung_id INTEGER
OPTIONS(description='kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Der erste Eintrag erfolgt immer aufgrund einer Listung, bei Auslistung erfolgt  ein weiterer Eintrag mit 0. Die column ist wegen art_list_wup_zu_per_2 eigentlich obsolet'),
vk_brutto NUMERIC(9,3),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT\n            '),
kdis INTEGER
OPTIONS(description='kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel_2 ist über den normalen Weg bestellbar, 1: der Artikel_2 wird  zugeteilt'),
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat_von, art_id) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='TP2 AIS - Artikel_2-Markt-Zuordnung - MULTISET\t\n             Enthält Informationen, wie Artikel_2 den Märkten zugeordnet sind, u.a. Listung, Bezugsweg und Normal-Verkaufspreise. Keine Information über Sonderaktionen enthalten');