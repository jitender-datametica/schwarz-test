CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_wug_1 (arthiertyp_id, wug_id, wg_id) AS SELECT arthiertyp_id,
 wug_id,
 wg_id
FROM kfl_production_dbp_view.v_wug_1 AS V01
WHERE arthiertyp_id = 2
GROUP BY arthiertyp_id,
 wug_id,
 wg_id;