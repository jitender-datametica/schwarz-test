--==============================================================
-- Table: transportation_unit_lagertor_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_lagertor_zu
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 14:02:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportation_unit_lagertor_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anlagejahr der Transporteinheit'),
transportation_unit_sr_act_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warenannahme- und Versandaktivitätsnummer: Transporteinheit'),
ladegruppe_versandstelle_id STRING(4) NOT NULL OPTIONS(description='Versandstelle/Warenannahmestelle      '),
lagertor_id STRING(4) NOT NULL OPTIONS(description='Lagertor '),
datzeit_erstelliung TIMESTAMP OPTIONS(description='UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss) '),
tor_distanz_gewichtung NUMERIC(13,3) OPTIONS(description='Distanz Gewichtung  '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id,
 ladegruppe_versandstelle_id, lagertor_id) NOT ENFORCED
) OPTIONS(description='Ermittelte Greenfield Tore');