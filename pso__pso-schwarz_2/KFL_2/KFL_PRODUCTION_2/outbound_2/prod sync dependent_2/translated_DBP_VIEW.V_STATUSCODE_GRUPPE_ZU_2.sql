CREATE OR REPLACE VIEW kfl_production_dbp_view.v_statuscode_gruppe_zu_2 (system_id, mandant_id, statuscode_id,
statusgruppe_id) AS SELECT system_id,
 mandant_id,
 statuscode_id,
 statusgruppe_id
FROM kfl_production_dbp_data.statuscode_gruppe_zu_2;