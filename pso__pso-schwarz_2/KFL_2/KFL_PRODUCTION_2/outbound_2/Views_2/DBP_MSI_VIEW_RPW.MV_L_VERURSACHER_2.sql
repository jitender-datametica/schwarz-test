CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_verursacher_2 (system_id, mandant_id, verursacher_id) AS
SELECT 7 AS system_id,
 mandant_id,
 verursacher_id
FROM kfl_production_dbp_view.v_l_verursacher_2
WHERE mandant_id = 1;