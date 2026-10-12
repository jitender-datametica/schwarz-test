--==============================================================
-- Table: transportation_unit_status
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_status
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:33:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportation_unit_status (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anlagejahr der Transporteinheit'),
transportation_unit_sr_act_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warenannahme- und Versandaktivitätsnummer: Transporteinheit'),
status_id STRING(5) NOT NULL OPTIONS(description='Statusart'),
statuswert STRING(1) OPTIONS(description='Statuswert'),
datzeit_buchung TIMESTAMP OPTIONS(description='Buchungszeitstempel'),
statusgrund STRING(4) OPTIONS(description='Grund des Status im WA/V'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id, status_id)
NOT ENFORCED
) OPTIONS(description='Transporteinheit Status');