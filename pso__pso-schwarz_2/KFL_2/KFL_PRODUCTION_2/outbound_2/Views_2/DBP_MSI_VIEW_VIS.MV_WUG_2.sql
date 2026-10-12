CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wug_2 AS SELECT mandant_id,
 arthiertyp_id,
 wg_id,
 wug_id
FROM kfl_production_dbp_view.v_wug_2 AS V01
WHERE arthiertyp_id = 2;