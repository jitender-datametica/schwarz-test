CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_wug_1 (mandant_id, arthiertyp_id, wug_id, wg_id) AS SELECT
 mandant_id,
 arthiertyp_id,
 wug_id,
 wg_id
FROM kfl_production_dbp_view.v_wug_1
WHERE mandant_id IN (1, 2)
 AND arthiertyp_id = 2;