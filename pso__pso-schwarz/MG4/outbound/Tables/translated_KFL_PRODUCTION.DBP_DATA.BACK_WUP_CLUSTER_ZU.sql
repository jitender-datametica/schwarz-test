CREATE OR REPLACE TABLE kfl_production_dbp_data.back_wup_cluster_zu (
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
wup_cluster_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Wup Clusters. Wird im DWH erzeugt'),
prio INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Prio '),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, wup_cluster_id) NOT ENFORCED
) OPTIONS(description='VIS Backshop -Zuordnung wup-Cluster zu Markt aus der Quelltabelle zek_bake_marktcl');