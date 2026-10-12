CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wug_2 (mandant_id, wg_id, wug_id, arthiertyp_id, wgi_id) AS
SELECT mandant_id,
 wg_id,
 wug_id,
 arthiertyp_id,
  TRIM(CAST(wg_id AS STRING FORMAT '000')) || TRIM(CAST(wug_id AS STRING FORMAT '000')) AS wgi_id
FROM kfl_production_dbp_view.v_wug_2 AS V01
WHERE mandant_id <> 1
 AND arthiertyp_id = 2;