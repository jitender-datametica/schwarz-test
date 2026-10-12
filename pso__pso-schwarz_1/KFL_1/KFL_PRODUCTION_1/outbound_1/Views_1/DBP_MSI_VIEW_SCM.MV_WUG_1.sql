CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wug_1 (mandant_id, arthiertyp_id, wug_id, wg_id, wgi_id) AS
SELECT mandant_id,
 arthiertyp_id,
 wug_id,
 wg_id,
  TRIM(CAST(wg_id AS STRING FORMAT '000')) || TRIM(CAST(wug_id AS STRING FORMAT '000')) AS wgi_id
FROM kfl_production_dbp_view.v_wug_1 AS V01
WHERE arthiertyp_id = 2;