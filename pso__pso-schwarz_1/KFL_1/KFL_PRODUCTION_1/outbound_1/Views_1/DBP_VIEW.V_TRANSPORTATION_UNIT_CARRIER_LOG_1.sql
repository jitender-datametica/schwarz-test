CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transportation_unit_carrier_log_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), transportation_unit_id OPTIONS(description='Transportnummer'),
kj_transportation_unit OPTIONS(description='Anlagejahr der Transporteinheit'), transportation_unit_sr_act_id
OPTIONS(description='Warenannahme- und Versandaktivitätsnummer: Transporteinheit'), beleg_id
OPTIONS(description='Belegnummer'), handling_unit_guid OPTIONS(description='Handling Unit_1 GUID'), art_guid
OPTIONS(description='Product'), ladungstraeger_status_id OPTIONS(description='Load Carrier: Log Status_1'),
anz_ladungstraeger OPTIONS(description='Load Carrier Log: Good Quantity Received'), anz_ladungstraeger_defekt
OPTIONS(description='Load Carrier Log: Defect Quantity Received'), anz_ladungstraeger_tausch
OPTIONS(description='Load Carrier Log: Good Quantity Exchanged'), anz_ladungstraeger_defekt_tausch
OPTIONS(description='Load Carrier Log: Defect Quantity Exchanged'), ladungstraeger_einh_id
OPTIONS(description='Mengeneinheit'), datzeit_erstellung OPTIONS(description='Angelegt Am'), datzeit_aenderung
OPTIONS(description='Geändert Am')) OPTIONS(DESCRIPTION = `LOAD CARRIERS LOG`) AS SELECT mandant_id,
 transportation_unit_id,
 kj_transportation_unit,
 transportation_unit_sr_act_id,
 beleg_id,
 handling_unit_guid,
 art_guid,
 ladungstraeger_status_id,
 anz_ladungstraeger,
 anz_ladungstraeger_defekt,
 anz_ladungstraeger_tausch,
 anz_ladungstraeger_defekt_tausch,
 ladungstraeger_einh_id,
 datzeit_erstellung,
 datzeit_aenderung
FROM kfl_production_dbp_data.transportation_unit_carrier_log_1;