CREATE OR REPLACE VIEW kfl_production_dbp_view.v_problemcode_gruppe_zu_2 AS SELECT system_id,
 mandant_id,
 problemgruppe_id,
 problemcode_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.problemcode_gruppe_zu_2;