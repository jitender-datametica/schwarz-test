CREATE OR REPLACE TABLE kfl_production_dbp_data.baustein_wup_zu_per_1 (
baustein_id INTEGER NOT NULL OPTIONS(description='ID eines Sortimentsbausteins'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_bis DATE NOT NULL OPTIONS(description='Ende des Gültigkeitszeitraums Format\'YYYY-MM_1-DD\''),
dat_von DATE OPTIONS(description='Beginn des Gültigkeitszeitraums Format\'YYYY-MM_1-DD\''),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat_bis, baustein_id) NOT ENFORCED
) OPTIONS(description='TP2/7 AIS - Zuordnung Baustein zu Wup_1 - MULTISET');