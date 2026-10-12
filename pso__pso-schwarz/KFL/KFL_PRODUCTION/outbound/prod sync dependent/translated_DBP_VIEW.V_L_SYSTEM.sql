CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_system (system_id, system_bez, kl_system_bez, kl_system_id,
mandant_id, system_rolle, system_gruppe) AS SELECT system_id,
 system_bez,
 kl_system_bez,
 kl_system_id,
 mandant_id,
 system_rolle,
 system_gruppe
FROM kfl_production_dbp_data.l_system;