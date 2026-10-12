--==============================================================
-- Table: transportation_unit_lt_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_lt_2
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:31:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportation_unit_lt_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anlagejahr der Transporteinheit'),
transportation_unit_sr_act_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warenannahme- und Versandaktivitätsnummer: Transporteinheit'),
beleg_id STRING(32) NOT NULL OPTIONS(description='Beleg-ID'),
at_guid STRING(32) NOT NULL OPTIONS(description='Produkt'),
menge_defekt_tortausch BIGNUMERIC(38,0) OPTIONS(description='Number of defective load carriers from direct exchange'),
menge_gesamt BIGNUMERIC(38,0) OPTIONS(description='Gesamtmenge'),
menge_gesamt_tortausch BIGNUMERIC(38,0) OPTIONS(description='Total number of Loading Carriers from Direct Exchange'),
menge_einh_id STRING(3) OPTIONS(description='Mengeneinheit'),
datzeit_erstelliung TIMESTAMP OPTIONS(description='UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss) '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id, beleg_id,
 at_guid) NOT ENFORCED
) OPTIONS(description='Ermittelte Greenfield Tore');