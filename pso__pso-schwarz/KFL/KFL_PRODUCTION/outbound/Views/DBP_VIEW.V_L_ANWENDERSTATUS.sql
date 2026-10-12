CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_anwenderstatus AS SELECT mandant_id,
 anwenderstatus_id,
 system_id
FROM kfl_production_dbp_data.l_anwenderstatus;