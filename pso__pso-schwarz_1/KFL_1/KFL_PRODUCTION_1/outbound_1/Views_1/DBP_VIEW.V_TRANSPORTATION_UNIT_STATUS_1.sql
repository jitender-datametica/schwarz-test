CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transportation_unit_status_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), transportation_unit_id OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit OPTIONS(description='Anlagejahr der Transporteinheit'), transportation_unit_sr_act_id
OPTIONS(description='Warenannahme- und Versandaktivitätsnummer: Transporteinheit'), status_id
OPTIONS(description='Statusart'), statuswert OPTIONS(description='Statuswert'), datzeit_buchung
OPTIONS(description='Buchungszeitstempel'), statusgrund OPTIONS(description='Grund des Status_1 im WA/V'))
OPTIONS(DESCRIPTION = `TRANSPORTEINHEIT STATUS_1`) AS SELECT mandant_id,
 transportation_unit_id,
 kj_transportation_unit,
 transportation_unit_sr_act_id,
 status_id,
 statuswert,
 datzeit_buchung,
 statusgrund
FROM kfl_production_dbp_data.transportation_unit_status_1;