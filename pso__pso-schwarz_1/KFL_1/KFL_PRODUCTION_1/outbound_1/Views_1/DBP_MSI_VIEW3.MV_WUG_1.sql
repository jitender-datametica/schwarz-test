CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_wug_1 (mandant_id, arthiertyp_id, wug_id, wg_id) AS SELECT 1 AS
 mandant_id,
 arthiertyp_id,
 wug_id,
 wg_id
FROM kfl_production_dbp_view.v_wug_1
WHERE arthiertyp_id = 2;