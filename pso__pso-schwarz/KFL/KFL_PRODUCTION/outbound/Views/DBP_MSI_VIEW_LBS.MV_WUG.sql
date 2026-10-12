CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_wug (mandant_id, wg_id, wug_id, wgi_id) AS SELECT mandant_id,
 wg_id,
 wug_id,
  TRIM(CAST(wg_id AS STRING FORMAT '000')) || TRIM(CAST(wug_id AS STRING FORMAT '000')) AS wgi_id
FROM kfl_production_dbp_view.v_wug AS V01;