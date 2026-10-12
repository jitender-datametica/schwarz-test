CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_problemklasse_1 (system_id, mandant_id, problemklasse_id, td_update,
td_insert) AS SELECT system_id,
 mandant_id,
 problemklasse_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_problemklasse_1;