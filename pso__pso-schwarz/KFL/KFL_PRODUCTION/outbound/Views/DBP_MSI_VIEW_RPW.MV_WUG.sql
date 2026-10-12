CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_wug (wug_id, wg_id, arthiertyp_id, mandant_id, system_id) AS
SELECT wug_id,
 wg_id,
 arthiertyp_id,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_wug
WHERE mandant_id = 1
 AND arthiertyp_id = 2;