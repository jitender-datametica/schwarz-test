DROP TABLE IF EXISTS kfl_production_dbp_data.art_list_wup_zu_per;
CREATE OR REPLACE TABLE kfl_production_dbp_data.art_list_wup_zu_per (
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_bis DATE NOT NULL OPTIONS(description='Ende des Gültigkeitszeitraums'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
list_quelle_id STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Listungsquelle aus der SAP-Tabelle wlk1. Z.Bsp 5 = Bausteinlistung. Eine Lookup-Tabelle existiert im DWH nicht.'),
struktur_art_id INTEGER NOT NULL
OPTIONS(description='Artikel ID des strukturierten Artikels, dessen Bestandteil der gelistete Artikel ist. Falls es sich bei dem Artikel nicht um einen strukturierten Artikel handelt, ist die Artikel ID des Artikels selbst enthalten. Achtung! Hier schreibt die Versorgung eine kl_art_id rein!'),
baustein_id INTEGER NOT NULL OPTIONS(description='ID eines Sortimentsbausteins'),
dat_von DATE NOT NULL OPTIONS(description='Datum wann ein Artikel zum ersten Mal in einem Markt gelistet ist'),
list_sap_id INTEGER NOT NULL
OPTIONS(description='in SAP zusammen mit Markt / Artikel / gilt-ab ein eindeutiger Schlüssel. Wird benötigt, um Updates aus SAP eindeutig zuordnen zu können. Wertebereich von 1 - 999, Standard ist 1'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
list_komponente_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Sagt ob die Listung des Artikels eigenständig erfolgt ist (0) oder als Komponente eines Display (1) gelistet wurde.'),
PRIMARY KEY (art_id, wup_id, nb_id, mandant_id, struktur_art_id, dat_von) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='TP2/7 AIS - Zuordnung Artikel zu Listung, Baustein und Wup - MULTISET. Enthält Informationen, aus welchen Listungsquellen Artikel und Markt zugeordnet sind, d.h. welcher Artikel in welchem Markt in den jeweiligen Bausteinen gelistet ist.');