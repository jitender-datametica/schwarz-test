CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_scm_tor_gruppe_map_1 AS SELECT mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 tor_id_zugeordnet,
 tor_gruppe,
 hallenseite_bez
FROM kfl_production_dbp_data.ts_scm_tor_gruppe_map_1;