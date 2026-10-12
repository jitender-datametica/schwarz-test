CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_verhandler_prompt (verhandler_id, verhandler_bez) AS SELECT
DISTINCT verhandler_id,
  CASE
  WHEN verhandler_id = ''
  THEN 'leer/empty'
  ELSE verhandler_id
  END AS verhandler_bez
FROM kfl_production_dbp_view.v_art AS V01
WHERE dat_bis = DATE '9999-12-31';