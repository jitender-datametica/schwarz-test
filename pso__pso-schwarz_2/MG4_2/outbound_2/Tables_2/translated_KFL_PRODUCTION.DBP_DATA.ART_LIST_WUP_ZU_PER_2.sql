DROP TABLE IF EXISTS kfl_production_dbp_data.art_list_wup_zu_per_2;
CREATE OR REPLACE TABLE kfl_production_dbp_data.art_list_wup_zu_per_2 (
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_bis DATE NOT NULL OPTIONS(description='Ende des Gültigkeitszeitraums'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
list_quelle_id STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Listungsquelle aus der SAP-Tabelle wlk1. Z.Bsp 5 = Bausteinlistung. Eine_2 Lookup-Tabelle existiert im DWH nicht.'),
struktur_art_id INTEGER NOT NULL
OPTIONS(description='Artikel_2 ID des strukturierten Artikels, dessen Bestandteil der gelistete Artikel_2 ist. Falls es sich bei dem Artikel_2 nicht um einen strukturierten Artikel_2 handelt, ist die Artikel_2 ID des Artikels selbst enthalten. Achtung! Hier schreibt die Versorgung eine_2 kl_art_id rein!'),
baustein_id INTEGER NOT NULL OPTIONS(description='ID eines Sortimentsbausteins'),
dat_von DATE NOT NULL OPTIONS(description='Datum wann ein Artikel_2 zum ersten Mal in einem Markt gelistet ist'),
list_sap_id INTEGER NOT NULL
OPTIONS(description='in SAP zusammen mit Markt / Artikel_2 / gilt-ab ein eindeutiger Schlüssel. Wird benötigt, um Updates aus SAP eindeutig zuordnen zu können. Wertebereich von 1 - 999, Standard ist 1'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
list_komponente_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Sagt ob die Listung des Artikels eigenständig erfolgt ist (0) oder als Komponente eines Display (1) gelistet wurde.'),
PRIMARY KEY (art_id, wup_id, nb_id, mandant_id, struktur_art_id, dat_von) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='TP2/7 AIS - Zuordnung Artikel_2 zu Listung, Baustein und Wup_2 - MULTISET. Enthält Informationen, aus welchen Listungsquellen Artikel_2 und Markt zugeordnet sind, d.h. welcher Artikel_2 in welchem Markt in den jeweiligen Bausteinen gelistet ist.');