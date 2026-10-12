CREATE OR REPLACE VIEW kfl_production_dbp_v_process.v_load_tp_thema_system_zu AS SELECT teilprojekt_thema_id,
 system_id,
 td_update,
 td_insert
FROM kfl_production_dbp_process.load_tp_thema_system_zu;