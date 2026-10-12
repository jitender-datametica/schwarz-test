--==============================================================
-- Table: ssm_wup_cluster_prozess_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ssm_wup_cluster_prozess_zu_1
   generated from Powerdesigner on Montag, 30. Januar 2023 15:35:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ssm_wup_cluster_prozess_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
ssm_cluster_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Sollstundenmodell-Cluster für die jeweilige Abteilung eines '),
ssm_prozess_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Prozesses'),
dat_von DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
wup_bereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID für die Bereiche innerhalb eines Markt für das Sollstundenmodell'),
wup_abt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Abteilung innerhalb eines Marktes'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, ssm_cluster_id, ssm_prozess_id, dat_von) NOT ENFORCED
) OPTIONS(description='VIS - Sollstundenmodell - Pflegetabelle der landesindividuellen Cluster pro Filiale und Prozess');