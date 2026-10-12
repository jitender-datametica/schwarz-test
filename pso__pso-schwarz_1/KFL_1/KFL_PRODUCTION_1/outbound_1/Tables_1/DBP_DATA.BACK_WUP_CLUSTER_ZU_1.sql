--==============================================================
-- Table: back_wup_cluster_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: back_wup_cluster_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.back_wup_cluster_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wup_cluster_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID eines Wup_1 Clusters. Wird im DWH erzeugt'),
prio BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Prio '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, wup_cluster_id) NOT ENFORCED
) OPTIONS(description='VIS Backshop -Zuordnung wup_1-Cluster zu Markt aus der Quelltabelle zek_bake_marktcl');