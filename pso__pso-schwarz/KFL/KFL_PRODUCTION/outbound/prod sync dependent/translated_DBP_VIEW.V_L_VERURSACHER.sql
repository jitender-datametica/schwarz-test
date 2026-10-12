CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_verursacher (mandant_id, verursacher_id, system_id) AS SELECT
 mandant_id,
 verursacher_id,
 system_id
FROM kfl_production_dbp_data.l_verursacher;