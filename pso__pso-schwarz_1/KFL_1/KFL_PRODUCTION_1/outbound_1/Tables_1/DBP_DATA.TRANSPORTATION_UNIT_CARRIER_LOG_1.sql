--==============================================================
-- Table: transportation_unit_carrier_log_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_carrier_log_1
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:29:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportation_unit_carrier_log_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transportnummer'),
kj_transportation_unit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anlagejahr der Transporteinheit'),
transportation_unit_sr_act_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warenannahme- und Versandaktivitätsnummer: Transporteinheit'),
beleg_id BIGNUMERIC(35,0) NOT NULL OPTIONS(description='Belegnummer'),
handling_unit_guid STRING(32) NOT NULL OPTIONS(description='Handling Unit_1 GUID'),
art_guid STRING(32) NOT NULL OPTIONS(description='Product'),
ladungstraeger_status_id STRING(2) OPTIONS(description='Load Carrier: Log Status_1'),
anz_ladungstraeger BIGNUMERIC(38,0) OPTIONS(description='Load Carrier Log: Good Quantity Received'),
anz_ladungstraeger_defekt BIGNUMERIC(38,0) OPTIONS(description='Load Carrier Log: Defect Quantity Received'),
anz_ladungstraeger_tausch BIGNUMERIC(38,0) OPTIONS(description='Load Carrier Log: Good Quantity Exchanged'),
anz_ladungstraeger_defekt_tausch BIGNUMERIC(38,0) OPTIONS(description='Load Carrier Log: Defect Quantity Exchanged'),
ladungstraeger_einh_id STRING(3) OPTIONS(description='Mengeneinheit'),
datzeit_erstellung TIMESTAMP OPTIONS(description='Angelegt Am'),
datzeit_aenderung TIMESTAMP OPTIONS(description='Geändert Am'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id, beleg_id,
 handling_unit_guid, art_guid) NOT ENFORCED
) OPTIONS(description='Load Carriers Log');