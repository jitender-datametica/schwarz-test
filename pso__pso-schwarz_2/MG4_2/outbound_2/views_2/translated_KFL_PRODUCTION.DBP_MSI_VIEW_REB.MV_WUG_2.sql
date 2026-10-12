CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_wug_2 (mandant_id, arthiertyp_id, wug_id, wg_id) AS SELECT 1 AS
 mandant_id,
 arthiertyp_id,
 wug_id,
 wg_id
FROM kfl_production_dbp_view.v_wug_2
WHERE mandant_id = 1
 AND arthiertyp_id = 2;