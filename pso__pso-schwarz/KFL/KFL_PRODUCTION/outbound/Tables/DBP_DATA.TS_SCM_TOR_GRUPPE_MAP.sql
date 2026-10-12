--==============================================================
-- Table: ts_scm_tor_gruppe_map
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_tor_gruppe_map
   generated from Powerdesigner on Monday, May 30, 2022 9:49:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_scm_tor_gruppe_map (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer / Lagerkomplex'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
tor_id_zugeordnet STRING(3) NOT NULL OPTIONS(description='Tor ID zugeordnet'),
tor_gruppe STRING(20) OPTIONS(description='SCM Tor Gruppe'),
hallenseite_bez STRING(10) OPTIONS(description='Hallenseite (WE/WA/Sonstiges)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lagernummer_id, wup_id, nb_id, tor_id_zugeordnet) NOT ENFORCED
) OPTIONS(description='Mapping SCM Tor Gruppe');