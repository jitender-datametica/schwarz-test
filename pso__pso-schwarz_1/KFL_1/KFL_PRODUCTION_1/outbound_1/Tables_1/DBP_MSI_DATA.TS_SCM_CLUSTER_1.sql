--==============================================================
-- Table: TS_SCM_CLUSTER_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: TS_SCM_CLUSTER_1
   generated from Powerdesigner on Mittwoch, 9. November 2022 09:15:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_scm_cluster_1 (
cluster_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Cluster ID, laufende Nummer'),
cluster_bez STRING(255) OPTIONS(description='Cluster Name, z. B. Zeitcluster nach Schicht'),
cluster_typ_id BIGNUMERIC(38,0) OPTIONS(description='Cluster Typ ID, laufende Nummer'),
cluster_typ_bez STRING(255) OPTIONS(description='Cluster Typ Name, z. B. Dauer, Uhrzeit oder Wert'),
cluster_element_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Cluster Element ID, laufende Nummer, nur eindeutig innerhalb eines Clusters'),
cluster_element_bez STRING(255) OPTIONS(description='Cluster Element Name, z. B. Frühschicht/Spätschicht usw.'),
zeit_von TIME OPTIONS(description='Cluster nach Zeit_1 oder Dauer, Intervall Beginn'),
zeit_bis TIME OPTIONS(description='Cluster nach Zeit_1 oder Dauer, Intervall Ende'),
wert_von BIGNUMERIC(38,16) OPTIONS(description='Cluster nach Wert, Intervall min'),
wert_bis BIGNUMERIC(38,16) OPTIONS(description='Cluster nach Wert, Intervall max'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (cluster_id, cluster_element_id) NOT ENFORCED
)
OPTIONS(description='Enthält Cluster und ihre Elemente zur Gruppierung von Kennzahlen und Attributen im Frontend (z. B. Zeitcluster). Befüllung über TS-Bericht.');