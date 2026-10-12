CREATE OR REPLACE TABLE kfl_production_eval.art_gp_nm_zu_per_de_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id INTEGER NOT NULL OPTIONS(description='DWH Artikelnummer'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode\n            '),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id INTEGER NOT NULL
OPTIONS(description='Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
dat_bis DATE NOT NULL OPTIONS(description='Datum, bis zu dem die Zuordnung gilt. Bei aktuellen Zuordnungen: 9999-12-31'),
vz_wup_id INTEGER NOT NULL
OPTIONS(description='Verteilzentrum, von dem der Artikel_1 beschafft wird. Falls der Artikel_1 nicht aus einem VZ kommt, ist in diesem Feld der Markt selbst gespeichert'),
bq_findung_id INTEGER NOT NULL OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess'),
bezugsweg_id INTEGER NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel_1 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, dat_von) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - Artikel_1 - Lieferanten-Zuordnung mit n:m - Beziehung. Enthält den Markt zur Herstellung der Eindeutigkeit. (entspricht etwa Tabelle art_gp_zu_per_1 plus wup_id)');