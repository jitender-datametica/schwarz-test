--==============================================================
-- Table: transportation_unit_kunde
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_kunde
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:37:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportation_unit_kunde (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
kunde_id STRING(10) NOT NULL OPTIONS(description='Markt'),
kunde_num_id BIGNUMERIC(38,0) OPTIONS(description='Markt (numerisch für CROSS JOIN mit wup-Tabelle)'),
dat_tour DATE NOT NULL OPTIONS(description='Tour Lieferdatum'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb'),
plantour_id BIGNUMERIC(38,0) OPTIONS(description='Plantournummer'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transportnummer'),
kj_transportation_unit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anlagejahr der Transporteinheit'),
tour_pos_id BIGNUMERIC(38,0) OPTIONS(description='Tournummer (entspricht Position)'),
zeit_plan_ankunft TIME OPTIONS(description='Anlieferzeit'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kunde_id, dat_tour, wup_id, transportation_unit_id, kj_transportation_unit) NOT ENFORCED
) OPTIONS(description='SRS geplante Tourdaten');