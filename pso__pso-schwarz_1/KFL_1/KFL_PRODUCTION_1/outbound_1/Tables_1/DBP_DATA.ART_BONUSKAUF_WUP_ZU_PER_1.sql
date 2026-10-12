--==============================================================
-- Table: art_bonuskauf_wup_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_bonuskauf_wup_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_bonuskauf_wup_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH Artikel_1 ID'),
bonuskauf_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige ID einer Bonuskaufaktion z.Bsp. 700 aus bbynr'),
dat_von DATE NOT NULL OPTIONS(description='Beginndatum der Gültigkeit einer Promotion aus datab'),
dat_bis DATE NOT NULL OPTIONS(description='Endedatum der Gültigkeit einer Promotion aus datbi'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_von) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Zuordnungstabelle der Bonuskaufaktionen zu Artikeln und Märkten');